Return-Path: <linux-pci+bounces-22613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E86A490DF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 06:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1B516E78A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 05:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19211BD032;
	Fri, 28 Feb 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hTF2tpk+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7B1A4F22;
	Fri, 28 Feb 2025 05:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740720554; cv=fail; b=tB4/jlFRFGkQA+oSF2FQWd4FbvcsHb3Wm7sNbm+WNVB7SouibXN6vE1qK4WXB2UnjhhP1Ip/CVNnXiINivISEULPXJs90LMCxc9g8cvTw6Md4mNWMOhw/qTJiTkOqzVdPkr7Kq1pe39ugxOfpjr+8bjj5RIEJJQAKP3JEV+v/L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740720554; c=relaxed/simple;
	bh=/xUTFPjxf4e6/KlIL7YFhrBWaIy14ouLwQzq131u+9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ce+EJVL07CW8B6MQoqKzH1vcWR9m3JbwL/InniztTqD1MSRU22xITbiGfqaLuFV2AfZVJk08C+D3f7+a5ULElflXjpPZxNeIpKSRFjM8+li9tr9akUrXEzgtgJ1BTcVT6HsDR/H+PoCsqTOghuFcqR/kioxoEhrliy8KmNqFEZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hTF2tpk+; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfVM1+QwSmSAeoFYyYbnGj9zocAsVA+/DLr9CovYExxh/DSeaOX5e3kwwyh9JJmNdNtfu8rttMGBhZRE5q3Ioy34nIMBgvKEoI7vatnSySv6g9bNGki00uCxN6TktvJhlg3e3yNLvsUidpwPwP92UtYXCoGZpwTKxMmzUSoP16kN9WUh4ePjrC9VGDbhOuwDnYlIFwL3ZXAdaMAHqhEboujj4siMGlkQqtCiG1fjw1EzjMohxqTL8oGN26TogQdsiwnhHxciGY/FKstAEbyzUMqWLkybKX4PLVzEMqpKJcT6H6vahuv7X4Y5c2t2w8pdwF6RnfLqGsIcq8d8TQ1LrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XM76GrIoXlQpL+YKOO4VrAdW84sXO+AjvbL7Qut22Y=;
 b=lspgmRXNKPzHAY6rBU7qP1wMk289twKTt9XMz5GUxXnKi2gw+oxCZeQqUY+kHJK5YF4D3cbEClGzEN5+FegVVfpmw7QM/edR4f9Kbkn1jZRHZ0nxPVENNXJIrtd1vt78zx9qQoaS7ZsaqEKCyYX9x11akM7pA4MUuS+X0sWcZ2fxYQi6nqou7QW9LgxFlR8GD00JorrD3Lqti35uwr9a1xVwZjyIj7KAn/ZZRKlQB6aYqPiUMHWvEpYQEAqMHfGbBSZlv2DBfiNMU7zzeAVfVRnZ8GNl2ufariLbk/84lLIHD8iNz8JBiVjmit3Xa576ZugnNdOte+3yRJTQF6qD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XM76GrIoXlQpL+YKOO4VrAdW84sXO+AjvbL7Qut22Y=;
 b=hTF2tpk+ZHbKbtATD7z2aZF7d4nEtdEzdNO88gzndrls2mctIcxMIY+Ip2jSKkDIPfu8I0/csQw8IlRDTr6R+LcHAFZGPVHK4FPOkPwDnXCwQdJZ/R9W65KXqcqHnIkuobaRRH8jODUQA0uPAo1UHcodLR1bnBB7zVPoA60xWwVniIusCcybB/XrKqi6JQMVNpleGaL1+FOwmjs6MZeS7YzFKcQLRhBnfpOkIoyRgEt2X+Q6iJIy8MjFeK2FSxp7HOq2+9QGXmw3VEcWx3rcXBG7EbSeH4JHjfO45MmF8CRx9b0yFeyk6NK1At3XdKVTHwfSZcA16OlcLC+xNlETxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 05:29:10 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 05:29:10 +0000
Date: Fri, 28 Feb 2025 16:29:04 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, j@jannau.net, 
	fabien.parent@linaro.org, chrisi.schrefl@gmail.com, paulmck@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
Message-ID: <w2udn7qfzcvncghilcwaz4qc6rv2si3dqpjcs2wrbvits3b44k@parw3mnusbuf>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-8-dakr@kernel.org>
 <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
 <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
 <wnzq3vlgawjdchjck7nzwlzmm5qbmactwlhtj44ak7s7kefphd@m7emgjnmnkjn>
 <Z72jw3TYJHm7N242@pollux>
 <nlngenb6udempavyevw62qvdzuo7jr4m5mt4fwvznza347vicl@ynn4c5lojoub>
 <Z8A4E_AyDlSUT5Bq@pollux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8A4E_AyDlSUT5Bq@pollux>
X-ClientProxiedBy: SYBPR01CA0098.ausprd01.prod.outlook.com
 (2603:10c6:10:1::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 83548964-860a-4435-ae2c-08dd57b8d3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tz01qkhx8KZ7nEKM8TkHZGZ+YNFbgi53eZp/Yfr07MDaz2HqXIfVD0Gy6ynt?=
 =?us-ascii?Q?IzwLINd2fQImQ8zWmPJoGb7eqwSQyiHFVR7pb6V/bbKe0J5ZkSzICyzgNpNg?=
 =?us-ascii?Q?P2zRAu2Bk4G8WuQh/TVaTnuVR56JTfOvVoFZp+gxbwuHPaqnrEt1lmptpdSH?=
 =?us-ascii?Q?65w7hrLSdKNx/ZRSvOVeui49e9ZssQhkW6BtxRPwADltkajYb0almGDue7RU?=
 =?us-ascii?Q?WV/CT2vq8H+pLd/7LJ16R2XKdLBXBs9795pl26yVYNhZxVEM812Oi0oZfm55?=
 =?us-ascii?Q?/DQJmAe/uuvovwbhe+8RAVro8NP7x9TE6YzRDLnWB1MGRjAE5K5z/NHR+Aws?=
 =?us-ascii?Q?aGpnmjYnybp0Z2t3C6gqeELB5CubBGzeCetEAf9PSZXjDo297dRb7pq5BOvw?=
 =?us-ascii?Q?/yomRVEDsrL0upQDtm0xs3mH7MBMNjDtC0pmoMtszMCJBHy80CzyA8nF9MCQ?=
 =?us-ascii?Q?9oMQGEj/eLf0hNFKsRa4rJBGgXjSdt8wbIiXyA0UQgy8DiVj+ne8bfvid7D0?=
 =?us-ascii?Q?yJwyD9MZh+YNNLzRQJjAyPnbCoTZti2buQkuwtp237eK/uJBwoZ5pMVIHrkx?=
 =?us-ascii?Q?wStQBoDuifi4h4Zz5ZZKWK0m9b7vEHX0SoR9Vzf102V+br5g82uEvASLUwKw?=
 =?us-ascii?Q?O5G5y3/SmJriilX0cb4fkKWc+zGv6RDsoCDEF86BiOc6s3gVqOKX75UKaCLK?=
 =?us-ascii?Q?sZco/sYx2HfHhPVI61+e09oxeHck0sDOmAdeMQ8weIa7pSyhHhWg8C8jRUbH?=
 =?us-ascii?Q?AFJDHet8vVHVyHDMggs0QWHUShLVUhXFh6WOcvSEk63CgOZ+lug+gdXbRV3X?=
 =?us-ascii?Q?a5ouSbGQzR6KRtW0FBG6wEvXw9LnZTJhF1oJOsxQHdhCdkjM3AbY9T1xTHi5?=
 =?us-ascii?Q?gu03i/aI/68gATB6HmXl6LHSaE7BlJwFCvjQagji7WfNwKATO1pjpTScqPYn?=
 =?us-ascii?Q?naOM7r6kSzTT4NS4R3fe1Gc+FLNavBqTQDgejZpXBHkpsqC/fOq64OAvK8V/?=
 =?us-ascii?Q?eHUp/CWDyglOdbGcodqx4ET694/Whs1c52nXPCOslFgLPDq9d72EsqYiz62r?=
 =?us-ascii?Q?BvLZtQtjoe9eUF6H+BfGGFSuwzvPGPNaYOZExO0rfuiCvjFXkWgtWdRlhXuy?=
 =?us-ascii?Q?Qtuz6fjAHnX6oyx3g10xZMMWiieSxIB+rz8/ka/3BoFH3nIH9OSnS3kzOnkn?=
 =?us-ascii?Q?YZhrp+HrP1tDJiQS0p5AgCT8QTB4xdKmQsVPop1dxfYoEFk5KW5en8LXuEI7?=
 =?us-ascii?Q?+s7S6t8ESfnbVjTzopU9NlY6wj7E8mnIn+zy/Qlbet1udq5z6HmbH+xM1+dU?=
 =?us-ascii?Q?PGlaSDdu3O166OQ1s4R8eCz6Y368+ckf5Z5gJViMe1uJEiFY/1dNUTfX3m1x?=
 =?us-ascii?Q?Ge5bPQ707aIwcyjdXHxUxi8Hyjnt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjSNDiXc/1xzwe+ES4rzp5ogO5GxQmAjNu8p0lEYyVki2Naei+62h23FpzNO?=
 =?us-ascii?Q?N0XdBNPDlOhJaOBhLHSxlq62CRkaV7NUfeQENdktTEsadYwiB3yNG1K9qaNE?=
 =?us-ascii?Q?+qDA24El1JR06JquhAGTmX4A5lT+wPcRlq0O0vQzsKavpu1LLraKOiikIv9n?=
 =?us-ascii?Q?IDk5eX7iAAX+3AIsLj5zNr1rcGN/997+BqvdJS+rguJnqi9Vi2AI94UNC3jq?=
 =?us-ascii?Q?eLCWa3A/DYsYpniLM6WgDHwSGiuPpfwI/hi5Ixn7e6cBGKozYvSVddcblz8k?=
 =?us-ascii?Q?XnW8v3p1GZaSyUZ59C997irdzk3qOCC6NlUMBwCyNkSib8Pf4VGMqv+yWr+E?=
 =?us-ascii?Q?s3+WqayjKlnMV7CtRuS84HWQPyAF9GdQGOswYlZYHSCJRCCKY+CvXwcAwnmJ?=
 =?us-ascii?Q?v7HATXl3AcZNgzs9Nkd8rL69zS8TWSoo8KzD/g+fpKXzDibKmkcclF5Aypyx?=
 =?us-ascii?Q?uSZ/rPK1zOUyLMUyspsJQrFuvq8JeUk7LYdkTko/nPpX32Sl1NV2ZTN93f2K?=
 =?us-ascii?Q?daf6er5r98D3HkYxBRcEpPt5ZjfS5PQ5ah4u+xPqES+Po2aGX6HMRjAZSGS1?=
 =?us-ascii?Q?dHdFHXiKhMniT5HnKLPe1mlDjjyvEEc8stD65FUHw3Cku6hqxOtsh6arKAdF?=
 =?us-ascii?Q?NK0pEqDSMSDMp7c2KqN00E1cYH8/zh5tqTz3F9T2rEzBE1aYKoqvDvMaWIh+?=
 =?us-ascii?Q?AybNniHNuZNG/sOIQG40MmkCm9zQ7wWjLRVUG18r2gcJnFxu1KNEwIEvbj3y?=
 =?us-ascii?Q?+N2YwpCNm1fb66f91/C/7DlUcm1KCDUZP8XOzkJzLn7gFeVuhSE51VyfEmNZ?=
 =?us-ascii?Q?nE0nwImm4Z2OcQxrSNTWfVZtFiH8HtWbudmHncjbd2i3liWI2OKatefQ/cXX?=
 =?us-ascii?Q?IAd0diZ26jzTLTpfR5R8tEw1Q0X9JqopNFjbr57JBayhTDgUzczS4b6MzG8/?=
 =?us-ascii?Q?pxWM3oXWEWae7nO6tp9h+uW9xoh+6/DGRivYgEjH2BUqe/q21zaMngmqrPB4?=
 =?us-ascii?Q?iWkXrfZrhbOsYs6xU5UivHp3EzmFcLe5TY6UQuwjLAhGlqtEdHDK0tlR6V2c?=
 =?us-ascii?Q?pDB8REy/ZeDw2xRstkBrdyfS00YUE8z1N5uoa6CQA3/nRQqtPLu6E4QTCD8I?=
 =?us-ascii?Q?srYXwA2lKYDxLM2UKRRrj5/6VrHsjDCnrgjA8mR3SFcQUOrNWU9WpTR3Gzaj?=
 =?us-ascii?Q?qJbOTiOH1kDMetqeimBWjHPx2ojq2sH4LK/l1loiD69P7trMoydjIe+OZxGs?=
 =?us-ascii?Q?9ZSppwPvQqHJNvUTwRxRoTs2+lLh4wTNJAOcs/onC926ieM4vNjDZHLwMXBF?=
 =?us-ascii?Q?/9IGVMUdebxRnRJSMy1tHnPIw5u2CSGPE7JL2Qh/PnGVq0nhEAAwwYAq6R2T?=
 =?us-ascii?Q?GX88X0P3Dl8HlMmW4oZaAZhuyy/gFcHFDHg+yZGi5zx9uo1j8/4Mix4sfmO+?=
 =?us-ascii?Q?b+8+TsHmFYuhfWQsQu3nobWSuQ6UP+V3xLY/0XjDnOD9P0RZ1fmaQ5VTqVen?=
 =?us-ascii?Q?/slHGn51brhlLGv4bp9gxOiiWnYFwi7tL945UJbFfOJD3AXA190hO/pfGpZd?=
 =?us-ascii?Q?ifteCrKkzy7ZDr9FQiJxvwAHtnMFp9p4n52c6QeQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83548964-860a-4435-ae2c-08dd57b8d3d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:29:09.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTp5U9LG5r8GeIDNY0VnEOZSejry6fL0bqigf9+YPx/IdPaAKC/wCP0NzhEulWJ/b2ubdRtbvnNJGCVTHDHi2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

On Thu, Feb 27, 2025 at 11:01:55AM +0100, Danilo Krummrich wrote:
> On Thu, Feb 27, 2025 at 11:25:55AM +1100, Alistair Popple wrote:
> > On Tue, Feb 25, 2025 at 12:04:35PM +0100, Danilo Krummrich wrote:
> > > On Tue, Feb 25, 2025 at 04:50:05PM +1100, Alistair Popple wrote:
> > 
> > > I think build_assert() is not widely used yet and, until the situation improves,
> > > we could also keep a list of common pitfalls if that helps?
> > 
> > I've asked a few times, but are there any plans/ideas on how to improve the
> > situation?
> 
> I just proposed a few ones. If the limitation can be resolved I don't know.

Thanks. The limitation is what I was asking about. The work around for (2)
works, but is not terribly discoverable. I will see if I can come up with
something better to help with discoverability that at least.

> There are two different cases.
> 
> 	(1) build_assert() is evaluated in const context to false
> 	(2) the compiler can't guarantee that build_assert() is evaluated to
> 	    true at compile time
> 
> For (1) you get a proper backtrace by the compiler. For (2) there's currently
> only the option to make the linker fail, which doesn't produce the most useful
> output.
> 
> If we wouldn't do (2) we'd cause a kernel panic on runtime, which can be
> enforced with CONFIG_RUST_BUILD_ASSERT_ALLOW=y.
> 
> > I'm kind of suprised we're building things on top of a fairly broken
> > feature without an idea of how we might make that feature work. I'd love to
> > help, but being new to R4L no immediately useful ideas come to mind.
> 
> The feature is not broken at all, it works perfectly fine. It's just that for
> (2) it has an ergonomic limitation.

I'm not sure I agree it works perfectly fine. Developer ergonomics are
an important aspect of any build environment, and I'd argue the ergonomic
limitation for (2) means it is at least somewhat broken and needs fixing.

> > > > Unless the code absolutely cannot compile without them I think it would be
> > > > better to turn them into runtime errors that can at least hint at what might
> > > > have gone wrong. For example I think a run-time check would have been much more
> > > > appropriate and easy to debug here, rather than having to bisect my changes.
> > > 
> > > No, especially for I/O the whole purpose of the non-try APIs is to ensure that
> > > boundary checks happen at compile time.
> > 
> > To be honest I don't really understand the utility here because the compile-time
> > check can't be a definitive check. You're always going to have to fallback to
> > a run-time check because at least for PCI (and likely others) you can't know
> > for at compile time if the IO region is big enough or matches the compile-time
> > constraint.
> 
> That's not true, let me explain.
> 
> When you write a driver, you absolutely have to know the register layout. This
> means that you also know what the minimum PCI bar size has to be for your driver
> to work. If it would be smaller than what your driver expects, it can't function
> anyways. In Rust we make use of this fact.
> 
> When you map  a PCI bar through `pdev.iomap_region_sized` you pass in a const
> generic (`SIZE`) representing the *expected* PCI bar size. This can indeed fail
> on run-time, but that's fine, as mentioned, if the bar is smaller than what your
> driver expect, it's useless anyways.
> 
> If the call succeeds, it means that the actual PCI bar size is greater or equal
> to `SIZE`. Since `SIZE` is known at compile time all subsequent I/O operations
> can be boundary checked against `SIZE` at compile time, which additionally makes
> the call infallible. This works for most I/O operations drivers do.

Argh! That's the piece I was missing - that this makes the IO call infallible
and thus removes the need to write run-time error handling code. Sadly of course
that's not actually true, because I/O operations can always fail for reasons
other than what can be checked at compile time (eg. in particular PCI devices
can fall off the bus and return all 0xF's). But I guess existing drivers don't
really handle those cases either.

Anyway thanks for your time and detailed explainations, I really just started
this thread as I think reducing friction for existing kernel developers to start
looking at Rust in the kernel is important. So I wanted to highlight that the
build_assert as linker error is really confusing when coming from C, and that
it's an area that I think needs to improve to make Rust more successful in the
kernel. Sadly I don't have any immediately ideas but if I do I will post them.

> However, sometimes we need to do I/O ops at a PCI bar offset that is only known
> at run-time. In this case you can use the `try_*` variants, such as
> `try_read32()`. Those do boundary checks against the actual size of the PCI bar,
> which is only known at run-time and hence they're fallible.
> 
> > 
> > So this seems more like a quiz for developers to check if they really do want
> > to access the given offset. It's not really doing any useful compile-time bounds
> > check that is preventing something bad from happening, becasue that has to
> > happen at run-time. Especially as the whole BAR is mapped anyway.
> 
> See the explanation above.
>
> > 
> > Hence why I think an obvious run-time error instead of an obtuse and difficult
> > to figure out build error would be better. But maybe I'm missing some usecase
> > here that makes this more useful.
> 
> No, failing the boundary check at compile time (if possible) is always better
> than failing it at run-time for obvious reasons.
>
> > 
> > > > I was hoping I could suggest CONFIG_RUST_BUILD_ASSERT_ALLOW be made default yes,
> > > > but testing with that also didn't yeild great results - it creates a backtrace
> > > > but that doesn't seem to point anywhere terribly close to where the bad access
> > > > was, I'm guessing maybe due to inlining and other optimisations - or is
> > > > decode_stacktrace.sh not the right tool for this job?
> > > 
> > > I was about to suggest CONFIG_RUST_BUILD_ASSERT_ALLOW=y to you, since this will
> > > make the kernel panic when hitting a build_assert().
> > > 
> > > I gave this a quick try with [1] in qemu and it lead to the following hint,
> > > right before the oops:
> > > 
> > > [    0.957932] rust_kernel: panicked at /home/danilo/projects/linux/nova/nova-next/rust/kernel/io.rs:216:9:
> > > 
> > > Seeing this immediately tells me that I'm trying to do out of bound I/O accesses
> > > in my driver, which indeed doesn't tell me the exact line (in case things are
> > > inlined too much to gather it from the backtrace of the oops), but it should be
> > > good enough, no?
> > 
> > *smacks forehead*
> > 
> > Yes. So to answer this question:
> > 
> > > or is decode_stacktrace.sh not the right tool for this job?
> > 
> > No, it isn't. Just reading the kernel logs properly would have been a better
> > option! I guess coming from C I'm just too used to jumping straight to the stack
> > trace in the case of BUG_ON(), etc. Thanks for point that out.
> 
> Happy I could help.

