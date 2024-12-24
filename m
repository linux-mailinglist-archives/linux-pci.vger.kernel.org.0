Return-Path: <linux-pci+bounces-19026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4747C9FC266
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 21:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0ED1882391
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A0142E67;
	Tue, 24 Dec 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="m5uqbPx+"
X-Original-To: linux-pci@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021082.outbound.protection.outlook.com [52.101.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEC8BFF;
	Tue, 24 Dec 2024 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735073697; cv=fail; b=gSS/t5N8CiEJcq4g4JfKvmhCzc3BisDyh8feKTNbJRGS3q249Zhr465g8JVn3EvMwem3N65uPrMgNnZspC2YifnrnqbDY2eF+7Uvh7BR+r+grbtCQMTkpSyJlt/R9WTTJrxpTmGrp6FJpoeUvUOmNRxw5JlL4PliqknjNAvXSbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735073697; c=relaxed/simple;
	bh=Y1gqGf23Nxf1R07clvDd4R3G2SWJo/p4wDCz0A8Syqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtI8on9oxeCKYP4UQP4K1lVAyxdw+uFjuaVNliw4SFp7sZsObP2ObJ9PIlYjPZjTZ6kyMObPNL6wAvJB3nviKm2ogVOOJEKbXU4zr4xzeG4jKeavsfGxH8CB6/IOBAOSECdqPx+XTWch4/R2Ic/OEevOSBkfZr9wqKmgNjSwc/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=m5uqbPx+; arc=fail smtp.client-ip=52.101.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V87JMBtY3/+MFp6JoweAZPk0JtdVyx/cd0+F4SvqIsXM/lHc4A56e2CyihDb5zkJJRm4R805ECHZsJgiowoFspMxSeTwaj/hY4/dhkyzM4A0k5J/3VwLJ2tA6fOuPJ0xFyxLRHnsHWee+xJ7RmNkddtSUDJnjnYYj3IXb7fP7SbyPk9viBVASwBtAeoS8QnmoLbZv5WwfTOrO4WAD1n5X+Loz/WitXkWMkJte0babmpZBfizU5QgvhzzR98gxJNbcS1u7IyuTCLfsjvBKcyQRHt/FQiScrZ8Pft6yxScP/omvz68aIDuzo+exk82qesR03yCuysyhw2Dar0H7uPu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J6QHsJvn8vPnVDgCSoeaV8ZD51OxELqHBd+YCJaB/I=;
 b=V1WTRb44nMcP0Qb2XSbFrm82bpYWP7egN2X5ilGO93gaoM+jY2dx3aecygdUSNCYl6Rq3lMzhOkMD8Uc0YKoExenHsotkaZgn0ajYhArOEWXGeFkItPP8wIbc0JfcmqnY7ZYQVXlI8i8/OMbW/wjfxt/2iYpdP7E13gCJ9S4YK8a2hoML4sjbzyOZ8vkq5+zM9iBDzX4RteVy+Jw+gQo+v7DCh8iTY1azvIH13N7d8+vMEJNpAIQcR6w1RRSTHh4VcEU/59lj6oMImGs0D8bHnISHTWxNgwXk6sIHd6e9BghaJ6ZGwbDA5ZUKveKSA0NRvkpfF45R2J5V4lGgUf92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J6QHsJvn8vPnVDgCSoeaV8ZD51OxELqHBd+YCJaB/I=;
 b=m5uqbPx+SsGHaR0op0thVfQvdCnAbg63NLXxrpidAMvnXyc5QW6hOOEd4GGpHBL0f3eeWwCy02GXvu2OcuOwXNeV7R13X0SzS/QBHFRRpTZ3sIF/Fx9kf7qK4wc1eEtXRSGa7447p8faTF288nsYM8YJBhBi9iJ8llZ1ljm0Rx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by LO0P265MB6421.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.22; Tue, 24 Dec
 2024 20:54:53 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::4038:9891:8ad7:aa8a%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 20:54:53 +0000
Date: Tue, 24 Dec 2024 20:54:50 +0000
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
 a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com,
 dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
 chrisi.schrefl@gmail.com, paulmck@kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 04/16] rust: add rcu abstraction
Message-ID: <20241224205450.20171869.gary@garyguo.net>
In-Reply-To: <20241219170425.12036-5-dakr@kernel.org>
References: <20241219170425.12036-1-dakr@kernel.org>
	<20241219170425.12036-5-dakr@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::19) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|LO0P265MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 585cf0fd-f6b0-401e-735a-08dd245d36fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C21q2y+NCuHQoGWk5Ig5sft2xzl3YCGKuWTgEwj+tSVv5qFaAEoIuWTIIDF8?=
 =?us-ascii?Q?5MhiWqwOePeqMc4ofquPUiusqegSkqA+HzO6XG41qcJWc8RHKQFzbXx9D5sy?=
 =?us-ascii?Q?/Yw8EotgaXtMIEenaS/7unkSwQddRR6hxvaxwSTfaV1ece/ETLBpC7y7MtJ2?=
 =?us-ascii?Q?fwI6VPEjoisXyg6vE+xI1VixP6+YItvlTnWvXCd8jr73e/LwhtZFQllzV7Z9?=
 =?us-ascii?Q?uW7PwVK1Mjc77+s0ol9+ovC/QPDX/6cCgU3xzrcQTFszo0D5/WWeg4h/FtoS?=
 =?us-ascii?Q?td45nlFao6ehgvaaQ6fag9tRFA3+l6wU4ZlIjPxXJ1y2AlhHZdHK8PT0LBrJ?=
 =?us-ascii?Q?ptg5hbhljY3zdJeKQ9XIOVviOLSOhW/9EkzDtCq4EiI7LECnpSRXDdg7JB6e?=
 =?us-ascii?Q?Oqaq+QFpJG08EPOs8TOA9BmWtcthafVOn6So/CdvJnGrswhwfRDfDsiNxAP4?=
 =?us-ascii?Q?+oq8PZw4htu89zVjdy7fyyz89oAFGSR+EEdKW3JUfqU582iFac7CjUHfVScW?=
 =?us-ascii?Q?tCdIoMsKsXvnws3oWMxagurRCYolvQqoPI4nd5hoHOGo9wBoCF0oL7T1PWyG?=
 =?us-ascii?Q?LNNO6QTNcZEjlJGmb/qCLGOvPq+eRz1m++hxQ8VIlBc76qSBRv4zyuvwp8O3?=
 =?us-ascii?Q?Elsez9Vb+ceme6PNE/LfM1WZUt6c96UyCby93WqLRPQ3n5OnB+FKhmN6D7tc?=
 =?us-ascii?Q?DIM6Xam0GywDjGlLDRVqwaofm0AeeSr2lB1VfzxZwnm66X0K7t6R7Abq4jQU?=
 =?us-ascii?Q?5QoTt/8kmD5cV1RRckhQBsVzpeuYFmI5vw0mAUMwRKDfjQ/u+y+zS3YN1lOh?=
 =?us-ascii?Q?KZGwtII5jwziui0cCnxnK+tWjc0Yz2HVyVXx84Biky6ixFM8cmI8hSNbT5mg?=
 =?us-ascii?Q?Q/V8weih2pNnMVNkHyaRQH/6dO1Uo7uALA/j3oolFa0/wC1ggBqTiuB58fE+?=
 =?us-ascii?Q?H8c+wqO+k/6IxWjSC5KFPbV8Ay8wEOwSJC+E2v8VCIkNOVZEZ0mO0fwXaHQ8?=
 =?us-ascii?Q?y+0kp5VvRhpLQ4W1HcUFOELIbOzNViSQnFcLeomNmvPRAYYa6nQ6Bkmaefrb?=
 =?us-ascii?Q?okXL6eebdIsdy8TNBa4Qj7q4nVHKZcPRjnX0S311la3axH327kT9mQ99bIPT?=
 =?us-ascii?Q?/xfrj5DCO9k8CdWAOkp/6TY9O/3vufmobiTi1zsj/YIHEqCr0IYIhNpeL44C?=
 =?us-ascii?Q?6la+rEdUfzdcDiR7/4GU2u+MsQBT0jpD89BSiISM/ZO4XpYAGGGBuGU5B/k2?=
 =?us-ascii?Q?jniNQ2ue+BGaXWqGgvjjy8cenHLHvSKmdLt/Z4gC52UFoUSM4LUfqzoiudS3?=
 =?us-ascii?Q?yledz8Ceu3YAa64eGZAnC+ldXCskZKFWcwSiOYUxF2d3gT9/EBlcILez+4Lh?=
 =?us-ascii?Q?GTaI8AjnLlPzdwI9NhTIvNhLdk+2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJ9Y9lvxhmFNcFst8ehQfGTwrdNfTryBxJskutlqVovsPlS9Kva/as7ugUn0?=
 =?us-ascii?Q?WgjRgIkrd+IGeqK6k6ITVQzYIn9QYZdP7Nbkr/cgtpJP4wx/w78pWqh/+rNs?=
 =?us-ascii?Q?073NYQonC7wnBh2hPeAVyk+sctUE6vtreuvnzSIWBlyAplJ+xt0eG6LzFL7r?=
 =?us-ascii?Q?Ws0qXjzmwE5qvKZhvMNwwIxXVFXikH9NU5/X9tzIIBX9m52RRYnRb2Ui0sNL?=
 =?us-ascii?Q?8+/ui+4q5lZ8jkOxUp+tyPMT7GOLOYTUpTuiYV5mN3xzIVTamZP+pwYnRkiP?=
 =?us-ascii?Q?trjG3WBQtsL0qlYQdf+engQeSHiZ2fM/DnxLTsdbfqqxXzz83gBIAFgMnydA?=
 =?us-ascii?Q?rW6gMhxoMaS5cvMO8zPpBtpRkECXT0td+EES3a+STmgUvyTnFA5EkJOk9KXX?=
 =?us-ascii?Q?Jv5sxWcqw9ulDYlg8xYm3yhAws2ryukqEh1oUX3mex1/dCBDZ4DO6NcjTQlE?=
 =?us-ascii?Q?qnUyRP9SipigvRrVAWyXoznh56pyzGNic/EZKzhrkSga96jwDayM1WsDhMXb?=
 =?us-ascii?Q?36O34J1orj6xUCh3VV90Uu4+2hvDJKHhraNT2dh1MrG4GHeLFEQNOwBPibZ1?=
 =?us-ascii?Q?UoUJB9+1o0fg2B0SV9MfDIxg02i5F5yat1HGNqe6dLCDlcbvpQKE5Isxi2VF?=
 =?us-ascii?Q?9WikwdQdBfqkoVVAm9PpR/4HUohLfgq4wqdj5ZTU8XuofexvL+rzzuk3wnYe?=
 =?us-ascii?Q?G84QjEmxGw+HNw5OKJA2O4p4o5ohVbC5xgtZUabOwQN6ify1VtQ3nciBLdy4?=
 =?us-ascii?Q?Xa7aO3IyZepmIyHsmun8KpQ3XJl8u4cXyZM58mtqjuS5ZcyaPCDSRwkHL2Lu?=
 =?us-ascii?Q?8c39xRdggtXa08Bicx58ImmIAmuSoMJN8qcLZsDpS1uMeMt9hZ2sqde95LKO?=
 =?us-ascii?Q?M3ZiawsKeHzik30Gqhi3KV2XVbsYycvbBgmYRRUGcCIVKbViJY4eaj4xt3hR?=
 =?us-ascii?Q?ycHsVJvs6liikHtcJ1tUArDjkYzIDoWkjRa2c4V3o7lal1OdAsjiKR2sjFxd?=
 =?us-ascii?Q?8omJLTHqZz2QAlBKsfGPwhka39kyL8q4YGJ3bemjV2fzfozxyl1HXc72hNor?=
 =?us-ascii?Q?3M4bfOs95SySy38AJXioIJdg1ieJtiIF8CT6P6x7vn7LD5HhTn3hnUrVA5rY?=
 =?us-ascii?Q?UAs7KVjZdSoAso+qjI8xpjsbLOZz7VUxYKzgIiAeE/I0Kjt52cQSPNjnQ7NM?=
 =?us-ascii?Q?zifaMAJPtIFoPY8U0Iio67U5espS+EQ0W5cy0GOI99Th0YIm93m+Q6PK5VhH?=
 =?us-ascii?Q?m0Ml9Ey5cI2QLxrsww7ppPOTn7IfP86lhEK/cuDaFZ/qqZqXauPdQNRI24KR?=
 =?us-ascii?Q?ZY0PZ1ifqgzfKBf5zZPw2YeonV3cAKCZ6FbLdUCIEGxT5MHTflWc8EDCoBQN?=
 =?us-ascii?Q?VQ4mIt/Je1/hnaaemCiH5eAsIZ3WJL+/7WUqSD6nhcixP+/KKJhmcHuf4moI?=
 =?us-ascii?Q?ZwgmVFq6SnSbL0baI/fP0Z0l9yYM73qm4g4IAu+d+ghXYlh6jFgKKRCHcpc2?=
 =?us-ascii?Q?KcsUoZmG2dCpz2IsmuUhwFg52cQjhD4Lh0k90nz5rYKzSMmo23tBoK6feOQg?=
 =?us-ascii?Q?KkZMZ94PYFuaAerYa8yGnRdNoxobPEGS9bGd5wJhhma9QZ6M43LWjWRK4Gi2?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 585cf0fd-f6b0-401e-735a-08dd245d36fe
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 20:54:53.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5n6gzdbjHC+YvepZGUSDZZJBlZb6xRollI1LoD2Ac+mC8ft0PX/lOvMdoagM67vSiTo+OsxTMjeVpK9Jdg3wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6421

On Thu, 19 Dec 2024 18:04:06 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a simple abstraction to guard critical code sections with an rcu
> read lock.
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS             |  1 +
>  rust/helpers/helpers.c  |  1 +
>  rust/helpers/rcu.c      | 13 ++++++++++++
>  rust/kernel/sync.rs     |  1 +
>  rust/kernel/sync/rcu.rs | 47 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 63 insertions(+)
>  create mode 100644 rust/helpers/rcu.c
>  create mode 100644 rust/kernel/sync/rcu.rs

[resend to the list]

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3cfb68650347..0cc69e282889 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19690,6 +19690,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
>  F:	Documentation/RCU/
>  F:	include/linux/rcu*
>  F:	kernel/rcu/
> +F:	rust/kernel/sync/rcu.rs
>  X:	Documentation/RCU/torture.rst
>  X:	include/linux/srcu*.h
>  X:	kernel/rcu/srcu*.c
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index dcf827a61b52..060750af6524 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -20,6 +20,7 @@
>  #include "page.c"
>  #include "pid_namespace.c"
>  #include "rbtree.c"
> +#include "rcu.c"
>  #include "refcount.c"
>  #include "security.c"
>  #include "signal.c"
> diff --git a/rust/helpers/rcu.c b/rust/helpers/rcu.c
> new file mode 100644
> index 000000000000..f1cec6583513
> --- /dev/null
> +++ b/rust/helpers/rcu.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/rcupdate.h>
> +
> +void rust_helper_rcu_read_lock(void)
> +{
> +	rcu_read_lock();
> +}
> +
> +void rust_helper_rcu_read_unlock(void)
> +{
> +	rcu_read_unlock();
> +}
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 1eab7ebf25fd..0654008198b2 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -12,6 +12,7 @@
>  pub mod lock;
>  mod locked_by;
>  pub mod poll;
> +pub mod rcu;
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> new file mode 100644
> index 000000000000..b51d9150ffe2
> --- /dev/null
> +++ b/rust/kernel/sync/rcu.rs
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! RCU support.
> +//!
> +//! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
> +
> +use crate::{bindings, types::NotThreadSafe};
> +
> +/// Evidence that the RCU read side lock is held on the current thread/CPU.
> +///
> +/// The type is explicitly not `Send` because this property is per-thread/CPU.
> +///
> +/// # Invariants
> +///
> +/// The RCU read side lock is actually held while instances of this guard exist.
> +pub struct Guard(NotThreadSafe);
> +
> +impl Guard {
> +    /// Acquires the RCU read side lock and returns a guard.
> +    pub fn new() -> Self {
> +        // SAFETY: An FFI call with no additional requirements.
> +        unsafe { bindings::rcu_read_lock() };
> +        // INVARIANT: The RCU read side lock was just acquired above.
> +        Self(NotThreadSafe)
> +    }
> +
> +    /// Explicitly releases the RCU read side lock.
> +    pub fn unlock(self) {}  

I don't think there's need for this, `drop(rcu_guard)` is equally
clear.

There was a debate in Rust community about explicit lock methods, but
the conclusion was to not have it,
see https://github.com/rust-lang/rust/issues/81872.

> +}
> +
> +impl Default for Guard {
> +    fn default() -> Self {
> +        Self::new()
> +    }
> +}  

I don't think anyone would like to implicit acquire an RCU guard! I
believe you included this because clippy is yelling, but in this case
you shouldn't listen to clippy. Either suppress the warning or rename
`new` to `lock`.

> +
> +impl Drop for Guard {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, the RCU read side is locked, so it is ok to unlock it.
> +        unsafe { bindings::rcu_read_unlock() };
> +    }
> +}
> +
> +/// Acquires the RCU read side lock.
> +pub fn read_lock() -> Guard {
> +    Guard::new()
> +}  


