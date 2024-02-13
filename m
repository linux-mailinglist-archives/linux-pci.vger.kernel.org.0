Return-Path: <linux-pci+bounces-3397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE3853406
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F080FB26BD5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141075F876;
	Tue, 13 Feb 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rW/09QKo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E116604A4;
	Tue, 13 Feb 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836391; cv=fail; b=dRt7ttr8QFysmNfnIm+dnMGnmpkAetNjsLBb9Mda118keG4YKjpRNUASPR5ivHxWjau2Qh14507UUV8Njfk8LJp7POKj6jMV1H3y36/2KhZTRAQ4BEc4n/x6GwQNEyeHKWs02UHUHj8hZSR0Em9I73k3ugzRiU5/irzVHDGqen8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836391; c=relaxed/simple;
	bh=inFKD5ujeQ6aWvtBZk4VsdF4clzBsegxzQqJkBjvOic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S9QPZZp2zVHoE56ssGgYvQ71Flbgpl8tKfxSnPIbxnnoNAIuI/iksa1y9qqfFd+e07oSdVpCECoMoray9HhAo3zWPCscP+0LslSPCrYuLrTbeXXMvjvKIUCLk1P+OmEKbUl8mq+72Iu9uWairmniZxiR+QFuG+avX8zJAgOvOZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rW/09QKo; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn/VtTmgGJP8ViQuUVDOuRc3NSnK2BV/y3YPMbl+i92uAHoHKUNsucEqlYh1IrCyeHnL5TV/ZiWqP9ZmNVtvlQzDT3c4usfZW2M06ZnB0P6YWv14DI2CWdpPmvwAMIOzFZJG96QsZe3WpNWw5CEHtYLdB1tR40sKpnJyPSV36pDdCvrjxfIZlyGZ7NOs+y9cGyzZeK3AdG7k62R7v15c63tMp2wqBwyL7mf2S8Yft+RDIZWet3uM/exTokct0RxlchAsa5z454zu2emBJLHXXahrnPte56x3rcPu/b7TGvW7mGFMoyBxKBL/VCQmLDIdoENVTa9kYKQtXIVQ8TWQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Co2SjszTo5nrEq4hgVB2XvFnwKGBYA8rzpasJiIKqo=;
 b=ZdqXTqU59AZuoFURESGlB0ixSdI0Z6Ace34j3qKAgpj0hMkb0K5zg1zVSH/MQB1R+yYJwkcZ2bJc6/NhFnUnDiwLV3dnpdp/7oeWOOIT8c6xfghT+OC5kBplRryPJyVv7UyI8gnEq6jWhN/Lp82/b+jUgpMQp6WSa5YimPsDxXgAbf5tyZ78D2RsEI5zGQN78ArCQkBdYe7EzkoG3OyvgQY0i7GZ/iMH5yVrSarlNXEP0vnvEmBTYGHMuniprAZfCTo1KdfHzWTY/C9BG57hdbWZAg2L/b8QYG7RxjCjYsoCPKA8cxZC6MA3P6I+UiG7BT+UjfD9AVVOIlfJkxBKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Co2SjszTo5nrEq4hgVB2XvFnwKGBYA8rzpasJiIKqo=;
 b=rW/09QKoicwNdgcwX85+dgQwbmyY/4ilh/qoN2oU8kwnMA4DylYrF8Kf+ZuvwIQ3mDaI5r1sO1MkjqCcb3yqKG70FwvEa/XQGrBsvoexQBWSxxtwv/AAZarfkokFNXViWdJ8hGTxeHAlpxk+8VKgT+NknERI/Ezp+QXPeIn5MwrtABi7Ws6aGIzlq7pveGgzMQ6ojeN86cQWiFl8yEDmNSrkkYDhqF9eZZgUBzRYzRCKgNqJLSI2fjIlJrsfFGxMwXhxwVEoM3FzrHG1yNkL9df3r41LpEDVpy2YQwbN0yuHEnhbD/ZVGBFyNLi303awfs9JA+Bb6IIvhza4XyZa1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 14:59:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 14:59:46 +0000
Date: Tue, 13 Feb 2024 10:59:45 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jim Harris <jim.harris@samsung.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pierre =?utf-8?Q?Cr=C3=A9gut?= <pierre.cregut@orange.com>
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Message-ID: <20240213145945.GA1088888@nvidia.com>
References: <20240211084844.GA805332@unreal>
 <20240212202714.GA1142983@bhelgaas>
 <CGME20240212225904uscas1p19a3d7743607a0abe3627fb8c4829f27b@uscas1p1.samsung.com>
 <ZcqitnWTh+zQ+H4p@ubuntu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcqitnWTh+zQ+H4p@ubuntu>
X-ClientProxiedBy: SA0PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:806:6f::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc8c1b1-2324-4e04-0271-08dc2ca46b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7qxdFqiN5wTdKfRRTqX6cVnBNAOx/m8Q4+69g+8g67qA5MvCOB6slAX9xInrSQXQVncgxfJBHKYzHEPJ+DyyOYO/b/YasEXxwwpl7VUdbMqX6oitL9i4mdIR7u1ekZkicAzenr+2bHIg6JUVzYA84i29RKumW5Mu643Zq/mcM+FsFGke8GsvoiU6h8sWHL6EeiCcS2fllZtOuJBnV5TXo6ePucizObWO2vlkSpEXvDVrwRzCiezYKPDm2S7iZg1HlIljZ7O0z05QVfwbR6tkMCRZIcj3Jkb8JjA06GyEIZTCW+1KyQ96D5sYrC9LvxydUB8b4owtLCvzQDyY0+GdCVShHuXFf+jbOWhx2r41JhOhxpXexyB0A7oZr81zrdGw2P7oVWaeCpxzt+eWOkNckzxFe46ITF+5/DCDEWPI/12Kqu0+2rENghrcmWOWylpNP3wbgb0IiEFXDueo/Y/KvjWblM5OomiX93kR4x3wcExJsUyP8qEG418vYghuqi6eGBnZVwZ2oZAkaetT5jqeYseKHK7SK8jRB9ZffPIEuorslMNVvzARnOyP8pZFRcWVHnXbiTfdN79xZPWvjS+nv5YO0l9cpe108nfa5AsZ8N8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6512007)(478600001)(966005)(6486002)(41300700001)(8676002)(4326008)(2906002)(8936002)(5660300002)(53546011)(6506007)(66476007)(54906003)(316002)(66946007)(66556008)(6916009)(83380400001)(2616005)(86362001)(1076003)(26005)(36756003)(38100700002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?boRLI4ijYYc+ojZgDPHuBj7YUK5i+JMfx6dEjOXhXX0XBfBJds+NzaytumTr?=
 =?us-ascii?Q?ZDwvVbvSeuzfq+4c5Xq5I5gUbTmvDwIDeqo6Hs93gf2lGf6eWiLZitHcvg+S?=
 =?us-ascii?Q?vk5z1jAQlMuT1N3Sp/dYyQLYeSijwtBkb0OGSqNzMxzYRLdaH5bxp5GGWHI6?=
 =?us-ascii?Q?S97mk7ltP08uJNnx15ZAFhOEoLKYMlDRcQS/chT3vQg4xNCws2b/vAEVXHDb?=
 =?us-ascii?Q?gg0ffOHwr8msiBEqmIW2VvdN6LFHAfH4rcfGyyVnZWz6f3FTVfcCJbxxIe44?=
 =?us-ascii?Q?6PK3OvgxerMQuc2Er47KipG0mGTRrzDMZmFUbTw8pTq7rME53KavMI6r5Sxu?=
 =?us-ascii?Q?D4YxN6xKYUkq/IHa0yLQDlmO8oC5Ix7QJdNTRw4tFkR5q6fQvRVIgafg5oYE?=
 =?us-ascii?Q?Y9a0ceFjyIaQvwPYdOrBG4EffiPF7HuFOBiNLEwz2jYFgFS8ofkkwSe/uJpR?=
 =?us-ascii?Q?BQeNZC0FmYXp1211wS/OP4YX15+es0J75+NjFNCj8ajPRB2oZrtaVEK99qc3?=
 =?us-ascii?Q?lf450RTIaCKEenw9olmziSfsX7V7YZV7Ikl4cKEQ1BCDFrcSKxH9SR5viWl+?=
 =?us-ascii?Q?6kcPYH7DRtIrM+CROcuLmQh9IGInBcP0tjhdcsdIUs4bHDksVTQeX36vyqyD?=
 =?us-ascii?Q?ZFXQl8fCg9Ba5k/3HR+bCPibC8a7iM81csFfUu+C24kNHJgYw8Rh3hrj+Hfz?=
 =?us-ascii?Q?RPTSKmDfhX6dvMnNIgqvVZZLUcpE3sH6lefYI375MeZ1Z89AALUpKgAkK45Z?=
 =?us-ascii?Q?Wnbfwk/l/PhsSoaWBT+7v3ZQG1wsQzfjy2hF1OZefR86n1FRG58BK9DIOMn8?=
 =?us-ascii?Q?Q2L0IbRtmr1URlN0wbhE5GIsfMJfW/durhBoOA/UoyrFVK1PGqg0Qu6miYU9?=
 =?us-ascii?Q?JyqoFqF0yfR7DXAulN7ltlG+xG3qCYgS0nyj6G5XGrlZjBToa5uiEh+USb6i?=
 =?us-ascii?Q?MztZCF1z9fKVEW4AxFH1hDAbavmWezk9kiXFwo+ZC5A3xXbiEpz3gRdpsWhD?=
 =?us-ascii?Q?X3gaXdJi0ct8AFwywjA8moBNXOOtuuvukV1PuvNgU91uxaI5y+Oh89bqaURz?=
 =?us-ascii?Q?83eX5nwhdOVuKqzYE75bTy+xtLaBWyoldSdgrMlOGupZ7cZ62UwlBtnm+34y?=
 =?us-ascii?Q?sKyWlaiMrFPelhepbQbX+CTo9qReCqM5T7jaAgcncgo7i5CKG4DX+w3eSbn0?=
 =?us-ascii?Q?Cy7kDbmuW/swNKAnpu4kThK6acoISQRN85lvVST/5lab137f2rGxgSbMqVEm?=
 =?us-ascii?Q?wFqPoGGfTlcBQRy0tzXNGXNo+Sy8+LTIZO37PxP6MK8OL/w9QC4K3DHtzBFp?=
 =?us-ascii?Q?6CY7DNLaQ6orqccBYwq1ib+7YE9yW0oDsmFbqxlhjDlXl4wxA/BPdYxnSf2U?=
 =?us-ascii?Q?i9ujvAiGOHAmUufMcXmSZ4ncus/J8lRoygK02tvghJpOf+TTsXA1FS0FbBeJ?=
 =?us-ascii?Q?Ai4EmQjH9Gs9foXhKnLkydD4nSfvxb/WlkWWvBw5XZmk8yoItD5lv8GaGIvl?=
 =?us-ascii?Q?tLP3ULJxZeeRCyoEk7rvPC7K+RcNMP9bHyVSwUXSbeouBX04X5vFyBa/Pui7?=
 =?us-ascii?Q?9/VAunV5jLD0trfnpA6ePAMavcTMXmjFDclZILer?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc8c1b1-2324-4e04-0271-08dc2ca46b58
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 14:59:46.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6WXGQFb+vx8nsmEPwf5/bj35QClz9874pFQmK79eg08TshFG6NgfO3TjhKPHqMD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541

On Mon, Feb 12, 2024 at 10:59:03PM +0000, Jim Harris wrote:
> On Mon, Feb 12, 2024 at 02:27:14PM -0600, Bjorn Helgaas wrote:
> > On Sun, Feb 11, 2024 at 10:48:44AM +0200, Leon Romanovsky wrote:
> > > On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > > > On 2/9/24 3:52 PM, Jim Harris wrote:
> > > > > If an SR-IOV enabled device is held by vfio, and the device is removed,
> > > > > vfio will hold device lock and notify userspace of the removal. If
> > > > > userspace reads the sriov_numvfs sysfs entry, that thread will be blocked
> > > > > since sriov_numvfs_show() also tries to acquire the device lock. If that
> > > > > same thread is responsible for releasing the device to vfio, it results in
> > > > > a deadlock.
> > > > >
> > > > > The proper way to detect a change to the num_VFs value is to listen for a
> > > > > sysfs event, not to add a device_lock() on the attribute _show() in the
> > > > > kernel.
> > 
> > The lock was not about detecting a change; Pierre did this:
> > 
> >   ip monitor dev ${DEVICE} | grep --line-buffered "^${id}:" | while read line; do \
> >     cat ${path}/device/sriov_numvfs; \
> > 
> > which I assume works by listening for sysfs events.  The problem was
> > that after the event occurred, the sriov_numvfs read got a stale value
> > (see https://bugzilla.kernel.org/show_bug.cgi?id=202991).
> 
> I don't think 'ip monitor dev' listens for any sysfs events. Or at least if
> I have this running and write values to sriov_numvfs, I don't see any
> output.

The issue is that the sysfs change inadvertently throws out a netlink
event (or udev event, or whatever) and something can observe that
event and then turn around and read the sysfs and observe a sysfs
result that hasn't caught up to the event launch.

The lock fixed this because it held it across the event launch and the
update of the internal state.

> It looks like the original bug report was against v5.0 (matching by dates
> and the patch file attached). In that code, we have:
> 
>     kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>     iov->num_VFs = nr_virtfn;

This is a udev event, I suspect the ip monitor event was thrown by
driver binding during the VF creation.

Jason

