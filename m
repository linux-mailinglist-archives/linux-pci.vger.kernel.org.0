Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47C9149FBA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 09:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgA0ITC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 03:19:02 -0500
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:26080
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729012AbgA0ITC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 03:19:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzyJCEMhmo8v04G6tJjG9+Xz6iLtwrASROgVy9chY74zpBd6XSlzoRpXLuahVxM5Xuafn7OfuFUxT2pVlINbIBkX6CkUUr+qQqaCf36jX3EMJvsIHWnIN/fuXgG6d7/TsgR92NMXn1qwNq1cCwlIAIVqhmy2L0AKyIwZMYWCCoFguoreq8Hd5IKEDVlPMFaUvU6cX4DYzhEfgU6ZA5rLDDSry9/6c5tV/NfcUxjoodh+U6EEHuYvh+w9zr9tw7ZCjR8bn3k2WTCYK3jEYYLoUSrNz23XSsNT9iYkYAkMzDgLWA9cCiGevEb9UMvGetZvH6cehSx5++uvzzwS9hGqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuTPIq3ifXLlLrspDZ58lFYAOquXQ8Nq8Mlg3QugY0U=;
 b=CdbOqyFTOgDB8Ux6hd1aWCF2U4K9XVWVg6wL4fslAUey9EoRMublhfRKpK3FI+9UyQLorcqGlw0n2rRNlZ42o+1tu5NhGIWfQHUKFenuKpGkVna5xSBlXxGPMvrSOR4FNLKu5m/6oQvoxylic7CwG8SDlV1HJcSjcfxqamGSCObuWs8GDDzDPrX3f9WVUB2uUBLtDJU9CZu1Z/hSsdrp5v35XSZHxRnomzZn2cK0Depss1V+0CFASbfX8Vri5C2QKB9e5m6V3fqPx1ZUiaicBxjWEkXqy8UKaLJ5ljNOOkh6Fk5j5B0sDvXeAWr0BCrQIoMVCH9t/ppjNKOMDZcMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuTPIq3ifXLlLrspDZ58lFYAOquXQ8Nq8Mlg3QugY0U=;
 b=Hci8m2ZDGjqS9qRNHvnXuiBqg7/exyxFRLA0fDBYv0DNi3ewSX1ifVy+6ql0b5Dj4eRpitbQoDeRNlcpz7zerZsCvS0qv2lQcj0N2G7dnBqRtGgg508HhhihEPsjDcxc1Gc70YZ/uOEqyRkR1P+ftbF0XeEQX7XBj9aMmOUCtlI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2549.namprd12.prod.outlook.com (52.132.208.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 08:18:57 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 08:18:57 +0000
Subject: Re: Disabling ACS for peer-to-peer support
To:     "Skidanov, Alexey" <alexey.skidanov@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Heilper, Anat" <anat.heilper@intel.com>,
        "Zadicario, Guy" <guy.zadicario@intel.com>
References: <BYAPR11MB29171883468FD79722FF3652EE0B0@BYAPR11MB2917.namprd11.prod.outlook.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3b62f9d6-5b93-e252-3419-3fe5307f7935@amd.com>
Date:   Mon, 27 Jan 2020 09:18:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <BYAPR11MB29171883468FD79722FF3652EE0B0@BYAPR11MB2917.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0060.eurprd05.prod.outlook.com
 (2603:10a6:208:be::37) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR05CA0060.eurprd05.prod.outlook.com (2603:10a6:208:be::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Mon, 27 Jan 2020 08:18:55 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 818b7324-8e2f-4512-fef4-08d7a3018de6
X-MS-TrafficTypeDiagnostic: DM5PR12MB2549:
X-Microsoft-Antispam-PRVS: <DM5PR12MB254934259A0D9B7989AB5DBB830B0@DM5PR12MB2549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02951C14DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(8936002)(66574012)(81156014)(8676002)(2616005)(81166006)(52116002)(16526019)(316002)(186003)(66556008)(66476007)(110136005)(36756003)(66946007)(6666004)(31686004)(2906002)(54906003)(5660300002)(478600001)(31696002)(86362001)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2549;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxGTxexlNZs8hLW8Mh0Ni69cHQDivtV04o1qXg05nwVg2DBDkAq0vSUPb/z2d9h3egOD2UVVzRNmaXlaIeW1lo35rLA3TUOm57UFCbBuvjkpMMRHzJpd8vKV3H576nIL3nPtel7Zs5suODZ3FRO7U+4Q8eLnV/uTxVOUbwxumZXYh7VD2JdL55Ao87NgD4ApUalTgso4Q0hYLgDYWrbE/gJAiSXc37fONqRA58WHB+ZIsYXqO/gbHG+I7d5prq2Tbp1oCoTpR1kBADuewQfo2A2cag8wpjwicJjDI5DufWxMvZvmfCytL6dCi5nKAWyXsVP1jTEuvWllGqytcS/PukTJsqPYcd7G+2z6FVkOHHp1fjvWN/ALgBCk59vet2EJPlAVmOlG9Xtz3BqtxfGZTMpGqZZVel5RJY+CSJnZzEc/FlmX1i//PZB3Asebr7E9
X-MS-Exchange-AntiSpam-MessageData: b+nHdp9FKzIuWuiTgqTgYDCDaR0Zzemnw8woXDy3DOjrfYuRt9pG/4h29K0WyZHVkEf4a7CbV0C+P7sb4KE1xjZxPc2zexDVnXEiEx37uIk9YwaofbnUzdJ1Q6lBQ/xsXj1ewweRTRAim8awFmtxTOjF0q6Uz22XTwtqWTK1pX3kJ354xae3mTl7X7fzHwRvNs/O83pNVxRAKDZqw3zE0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818b7324-8e2f-4512-fef4-08d7a3018de6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 08:18:57.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7vm3bMkb+1r09UiowptXCINSyrLMpIj+nqeRiWrXm8S4ywxeeZSSLSPwuMmR9YG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2549
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 27.01.20 um 08:18 schrieb Skidanov, Alexey:
> Hello,
>
> I have recently found the below commit to disabling ACS bits. Using kernel parameter is pretty simple but requires to know in advance which devices might be participated in peer-to-peer sessions.
>
>   Why we can't disable the ACS bits *after* the driver is initialized (and there is a request to connect between two peers) and not *during* device discovering?.

That's exactly what was initially proposed but we have seen hardware 
which reacts allergic to disabling those bits on the fly.

Please read up the discussion on the mailing list leading to this patch.

Regards,
Christian.

>
> Thanks,
> Alexey
>
>
> commit aaca43fda742223e4f62bd73e13055f5364e9a9b
> Author: Logan Gunthorpe <logang@deltatee.com>
> Date:   Mon Jul 30 10:18:40 2018 -0600
>
>      PCI: Add "pci=disable_acs_redir=" parameter for peer-to-peer support
>
>      To support peer-to-peer traffic on a segment of the PCI hierarchy, we must
>      disable the ACS redirect bits for select PCI bridges.  The bridges must be
>      selected before the devices are discovered by the kernel and the IOMMU
>      groups created.  Therefore, add a kernel command line parameter to specify
>      devices which must have their ACS bits disabled.
>
>      The new parameter takes a list of devices separated by a semicolon.  Each;
>      device specified will have its ACS redirect bits disabled.  This is
>      similar to the existing 'resource_alignment' parameter.
>
>      The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
>      Egress Control bits are disabled, which is sufficient to always allow
>      passing P2P traffic uninterrupted.  The bits are set after the kernel
>      (optionally) enables the ACS bits itself.  It is also done regardless of
>      whether the kernel or platform firmware sets the bits.
>
>      If the user tries to disable the ACS redirect for a device without the ACS
>      capability, print a warning to dmesg.
>
>      Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>      [bhelgaas: reorder to add the generic code first and move the
>      device-specific quirk to subsequent patches]
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Reviewed-by: Stephen Bates <sbates@raithlin.com>
>      Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>      Acked-by: Christian König <christian.koenig@amd.com>

