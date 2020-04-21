Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30BE1B2CFF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 18:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgDUQn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 12:43:27 -0400
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:35457
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgDUQn1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 12:43:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDkkq5pkTkJI/TMPXqFuhj4zN7gUPMOSjSLsKi/h2yi7iyiztliuH6bYWZCnugzstp4pxDkPbOOpoby+vt1W3s0YHKdeqHjKaW5zFBb9YokouM4OUEmJgska0kyGYm1rpUB1DUOt/fo334HGz595d/SAIFv9mgtUqnztQ3qSvWaGtq9RLUAEi0jqGQj3yhBpZaLvtvzhwXi95tXqqHpT/Dwnm8tVZrU2O4D6hS6jZreoqphQDPHZbkXpF6c3RAHT7Pc5sKdBKeSSb+t9brI8aFsXnJVz1T9w1RYddE2a2dJq6f7zkMV+BbnV8u3jd5r+qUu9J6TA6whma0tLg8cfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MygwmPobZobjY6g2LliRu6EmpnkFZrlfBvQsat8zWEo=;
 b=fqfT964g3MBGw8nBkMZjQ4kZ+ERCYs7+k3h0VentSe5sPry/oHG9M9pVOqzHpDJUDqFF0vXyb9QpCs7YlhX47i1mmjaKWg/qJGQe4oSjVXiyInft93p9FOztkmh19o0PaNEpTt38XhZAWkT1ZWmlg2W4f4BX6fwoSDI60u8VQaLroJgbRciCyMRIMx20D63fvvnsq8gt1Qy3AaDOZ4YruIWMi05x8qtUhmy58noeadst/tpfe55DW6fH1ylBOVFygL4/Qqjd35tX9re0i/fISZ87M0b/G44UOXxH/NC4qbahnf5XgI/9eAtuwK+s4wx+EFX3PaDVS2O636n8VDstSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MygwmPobZobjY6g2LliRu6EmpnkFZrlfBvQsat8zWEo=;
 b=wvnKWwV2kvArfVk7YuA6gsxcD5HwrA7fqowTZohphxblnQLRRYupckr7+IqWKfK6i2W0AQijgFtTj8ZIypAQ3HUjpjk+6z3720fJIL4FTaVYGnNomdIwXZnkAMGwxjjzt+Ehy26ecI1/1Ymtg61RqutfspMp7HUSvnicXRPX7tI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 16:43:22 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 16:43:22 +0000
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices on
 the root bus
To:     Ard Biesheuvel <ardb@kernel.org>, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, jon@solid-run.com, wasim.khan@nxp.com
References: <20200421162256.26887-1-ardb@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
Date:   Tue, 21 Apr 2020 18:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200421162256.26887-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0051.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::31) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 16:43:21 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44292beb-9b77-4a7e-b89b-08d7e6131ab6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4057DA0F31193060F235A54083D50@DM6PR12MB4057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(31696002)(36756003)(16526019)(66574012)(2906002)(8936002)(31686004)(4326008)(316002)(86362001)(5660300002)(186003)(52116002)(2616005)(8676002)(478600001)(66476007)(81156014)(6666004)(6486002)(66556008)(66946007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcBa2MtEvnZOFDKKW1osxVHje29XlD0o9DQoBnnkOYviRrord4g4sZ73nuGQ5o+UDcXIRMEjVp2XhBUynoDGlfPcVIZ0+R9RPkerNHOvzs4R5xK2CgSuc6CqDQRNYR6ywht7N877M8gfZSNPxedXCxGcU19qBIoP7YGkqiTKy3f7lZZJnJydxri+K2d/W6cPyky3hnrlaXyxtFeeCq2UtAGp14ezAW2HQj5bQew1wOAeyYXL6BehHAwclTC4TxFpwcjzxS+427/6gMAPTN6I90UT0VDBpb2zUj3v4xMfQ/ire42KwblRlJOwnlcbBPalHtAo5ojbyRwZZMhMx1u1UD8HZJxyDKFvAmmZ0zRJTgS3fGNjl9SaTGx1Llluylg2I4xlLmPHoZy5sW+G+u4PWmUP+TBkm8GWY/6vinDCFq7cNJ5wqtGfDU3uy0eM0oV5
X-MS-Exchange-AntiSpam-MessageData: B3AK6vpVPre0tlCAy9DWPpMw5QZXvOknA1xsXH5QGOkD3XW57ba0+qjx9H6PaRXu/XsE3LdqFhgmgQR50QaQ3JA0MKeTAmdtbFJRYhlTot2ViHuh+C0vE41w+7fGwQ6bk/bP/YbC+fraEzPitP73AQzGg0DAEJ8Dx9MIHTq30K8i1fkE2Xjzpiq6u+nfLyqAS/0FBUbV7DR3TxtCOwIqrA4HVkOJ/wIYoWr8o6HArMaJt7IFxYqGCicEnrn0S6CQyTV5L2XCp2p3HTpCzUV/g62Yaq/G7E58M53o06qzCsBuqN8qp7EWcNQABKA4M7pqX5ntxAGv4ucuBFx1pAb0ifv88ig47bZVs381xuzs4jHFkPYkPIbL6ezNkBDIhrWJBMV5e3gW2msdlbLSsrSPCE+jZtrnxFNjyZcQmL8iGBt1GFUlvAdoWTUFIRlPP9fY18Ma/VgUzi+a1YiyfgPTUG792iPh3f1SXN+XI8XoSoB0cjVxxZgdx7Jj9W0XOiF/RaBtDp534D71JSY+g2NAChTkMJqjsx/x74RoXmwUkExIBAKiKTg40Y0iDtWBXvSHXx/2lC1W2rDg2afssZmQKRnd9Xfn3ysgtFWrHEwulDctusSVlKEw9fpjfpueizHzV1rcOC2djj1lCB9sDkPnP8rXY5deuMAz9xcZTqYcEbctGBro0WuuTzr3GexiJT2jDQo63kLB6n1iiB8VCixARGeqvxr6CJs2aYlpIfER1dMnIkZQ/biC/ztpyCXzyIDtBRw3qboXapQ/YNlBD9xWCueqbe3jdav6AlrCyIVVPakjosMdaxTHnym1AXVvfDLMgX5f6NzvJgOS1u7BIRmFVasXDL7P+Revj1HYNi9+Ex8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44292beb-9b77-4a7e-b89b-08d7e6131ab6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 16:43:22.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4kp5j47IgiFmt4bi2W7ZkVYd0EXq7urG1js5cYH+E2gEH1mO7JjXClbhl7oRmYc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
> bring the bridge windows of parent bridges in line with the new BAR
> assignment.
>
> This assumes that the device whose BAR is being resized lives on a
> subordinate bus, but this is not necessarily the case. A device may
> live on the root bus, in which case dev->bus->self is NULL, and
> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
> will cause it to crash.
>
> So let's make the call to pci_reassign_bridge_resources() conditional
> on whether dev->bus->self is non-NULL in the first place.
>
> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resizing BARs")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Sounds like it makes sense, patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

May I ask where you found that condition?

Thanks,
Christian.

> ---
>   drivers/pci/setup-res.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index d8ca40a97693..d21fa04fa44d 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -439,10 +439,11 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>   	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
>   
>   	/* Check if the new config works by trying to assign everything. */
> -	ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> -	if (ret)
> -		goto error_resize;
> -
> +	if (dev->bus->self) {
> +		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> +		if (ret)
> +			goto error_resize;
> +	}
>   	return 0;
>   
>   error_resize:

