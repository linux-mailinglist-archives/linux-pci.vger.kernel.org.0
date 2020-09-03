Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA525C59C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 17:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgICPpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 11:45:31 -0400
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:41635
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbgICPpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 11:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oh+bd/99md9/MECAOH9zvVZocq9lmU4KVz7sEQD2dxeH7Ey9Hqn1XdjnM54dy7NjI8GJ9k5f7IRtkQ50ut+aJNpNEw7wKX8G8VUQygjX1cDfJybNl8hvLHOkLmmTqcsMr5XrMkJ/eGH419qlUZ+xYGFPA6JqfLWgdTolHtN36LWhnwBHEZoloB0ZK3cN3h8eh1jyx73whpcrhJ/vGFXJbV8KkKwClI2cJN4PM1IKn7x3QLdzMk2gwKTInfa2pjITkz3QCtE7rxTq79Dhdg9nyuPDDAc8cR8TvXFrNrGmXusgMG6vq2vCpP+lkSBvBfHMBERJMjhsRWeHtQSrWuhu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoEpJwpuGn+nasSPZCr5cmCjqodpJ3Y10aI7LzLqfDs=;
 b=mOL2MPwWHLrGi1+1086odgiYCMGfZuEqJPzY96ztfSey62I+22+FOEGW4yZB0iBIxgMROBSt0AgD5Ye0H9exZjsXWi1d/25OZuZd2QKXRsSdUNY2/BR3u6Y2n3Imfsu27Vd8lHMCQin6Scm/jwNI1zZE4wkIlryS/tf285vmPxU88EnTXkdcpAy640a9GDJ3YOUd9M1A3/AUj986DEY9vTwuA0iMxR22TzcLk9pKGdrr7z7bclIxhV2KcK1m+SfMN1E6noaIbxp1Ae0CXRCZ4pftIQc1AuU+n+n0ZRee1prsvdevKAuKDpRMx+B0NP2omuJtObgEKpPUpwzpN7V+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoEpJwpuGn+nasSPZCr5cmCjqodpJ3Y10aI7LzLqfDs=;
 b=AgVHTRktb0xsTO9OvMnP4igPfeukfEZ9VktMzpy8nbfS9P7aeImgp/jJx9G3C4Vg6zobaPB5kqtMIPS1J+AG/o1G/U6GtJVby+Sw9Fh0zbADlCu7vrhotzFFW5xRZYZCk61lJYv9MFsO49eR2PlC+V4C2rFYS5tOp5Um26bU6iQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Thu, 3 Sep 2020 15:45:27 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 15:45:27 +0000
Subject: Re: [PATCH v4 4/8] drm/amdgpu: Fix consecutive DPC recovery failures.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     amd-gfx@lists.freedesktop.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, alexander.deucher@amd.com,
        nirmodas@amd.com, Dennis.Li@amd.com, christian.koenig@amd.com,
        luben.tuikov@amd.com, bhelgaas@google.com
References: <20200902222359.GA272485@bjorn-Precision-5520>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <8388b5b2-b39b-03bd-602b-22cf960396ac@amd.com>
Date:   Thu, 3 Sep 2020 11:45:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200902222359.GA272485@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 15:45:26 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9322ad3-054e-436b-f425-08d8502060e4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB248791949014105972DE5452EA2C0@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6tkFblFqSKxXZZyY/u5ikdP2XFmXW1yh9x0S4y+TCLzyC57XtmpMtOqiZDxDSPxnH1HrrrB9CfPOpLTrJp1i2H5xRi/zieaIEsivoCJqSdjuaCHMs2ygBHYUo3KgqHobod522idmtix4BYhU/x2DhwYuor6JcenSx74484jjFPKeMWS+wMfz9O5yfQMjcV/k2LaxB06h06mX7a3Cr/dp1A74OH+EXCFRv4zg9hTpgcb3RhyePtQpfVxCjq6DgxwNu2OqiMhqIWIUQsFelg9feITwjTsx58A3VQcNvc3sCuedKgjqFn0IJ2X1GfKQNGswK8EDqfkzfTczaMqNsjRmEDvr10NhIasAPr6ZUx+nTDVq+j1wMR9AN1FtpCsDTga
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4340.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(2906002)(86362001)(8936002)(5660300002)(66476007)(66946007)(66556008)(31696002)(8676002)(16576012)(186003)(31686004)(4326008)(83380400001)(2616005)(6486002)(956004)(36756003)(52116002)(478600001)(316002)(26005)(53546011)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NjqNM1KbsTbVTri7DGTWgy1d3Zdj6Pyh0a85K4/qpi3UDjwUg1b0py47qjgPT8zlQNJVolFK7mOMgYwZiPyavvsuJLry4Go6eZal9BY/ZcG5mrpvmKnJVUTKYlnwUjXUUMEKV0SZXgcBhTKlR9thW650l07psiQzKWo1U/PKck9FWzGm/2qnwb1UJpAxfJOeqsrzisiovar1M7ECOCsjgl0SRZMaBDHMAKe8n8ODAVMo/kkVn+NF+NglN7Ojv94O2W/RDcitWNghYNPU3sSAPlIlcl9qZh2LWQCQ2ev1ESESTb7kGY8WwQgsYNr0OXSuZAs6aue17Bb2MYzvrc7tqHELwZ87huG5UAMe+5ziYL/jgzFMveq2+NNlCsz+PCnMZjOaW5tg7WYQ98QfWrHGaKoFPSf0evI/jObevq8Rxsa0ayDNV4NlU+ddPq1hSTeVWVS5FiwDnBbAwJdxkrLpeP5l1zlLumWAokAaPZRrde7+o/tzMRWM9rlGfp3RYrt/oGIhxzpIPPYskM1VXRyePhaL/X7GefoRX84fF3tkSVBtU8eVGcWwQpNOgFd2/G4lohzdXyKOH49Bw1KhLVVvUdADz2hKvbZMeJ8VA9rKHXmatKbzLAA/hAUXZgPhcI9CER02ba3RWm5FSgoJ8diGhw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9322ad3-054e-436b-f425-08d8502060e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 15:45:26.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a79owDzgYGG2+DSY3VJgGXL7s3bLh8VM/J3PST2BkzdphfXAFnfHHOdaTOJxCBa57fB5WlhQEUx/4TDUwovD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/2/20 6:23 PM, Bjorn Helgaas wrote:
> On Wed, Sep 02, 2020 at 02:42:06PM -0400, Andrey Grodzovsky wrote:
>> Cache the PCI state on boot and before each case where we might
>> loose it.
> s/loose/lose/
>
>> v2: Add pci_restore_state while caching the PCI state to avoid
>> breaking PCI core logic for stuff like suspend/resume.
>>
>> v3: Extract pci_restore_state from amdgpu_device_cache_pci_state
>> to avoid superflous restores during GPU resets and suspend/resumes.
>>
>> v4: Style fixes.
> Is the DRM convention to keep the v2/v3/v4 stuff in the commit log?  I
> keep those below the "---" or manually remove them for PCI, but use
> the local convention, of course.
>
>> +	/* Have stored pci confspace at hand for restore in sudden PCI error */
> I assume that at least from the perspective of this code, all PCI
> errors are "sudden".  Or if they're not, I'm curious about which would
> be sudden and which would not.


Yes, all PCI errors are sudden from drivers point of view indeed, I am just 
stressing
the fact that i have to 'plan ahead' and store working PCI config because to my 
understating by the
time when we are notified of the PCI error in err_detected callback the device 
and it's PCI confspace
registers are already inaccessible  and so it's to late to try and save the 
confspace at this time.


>
>> +	if (amdgpu_device_cache_pci_state(adev->pdev))
>> +		pci_restore_state(pdev);
>> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
>> +{
>> +	struct drm_device *dev = pci_get_drvdata(pdev);
>> +	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	int r;
>> +
>> +	r = pci_save_state(pdev);
>> +	if (!r) {
>> +		kfree(adev->pci_state);
>> +
>> +		adev->pci_state = pci_store_saved_state(pdev);
>> +
>> +		if (!adev->pci_state) {
>> +			DRM_ERROR("Failed to store PCI saved state");
>> +			return false;
>> +		}
>> +	} else {
>> +		DRM_WARN("Failed to save PCI state, err:%d\n", r);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
>> +{
>> +	struct drm_device *dev = pci_get_drvdata(pdev);
>> +	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	int r;
>> +
>> +	if (!adev->pci_state)
>> +		return false;
>> +
>> +	r = pci_load_saved_state(pdev, adev->pci_state);
> I'm a little bit hesitant to pci_load_saved_state() and
> pci_store_saved_state() being used here, simply because they're
> currently only used by VFIO, Xen, and nvme.  So I don't have a real
> objection, but just pointing out that apparently you're doing
> something really special that isn't commonly used and tested, so it's
> more likely to be broken or incomplete.


See my assumption above, I assume I have to explicitly save (cache) the PCI 
state while
the device is fully operational since I assume it's not possible when PCI error 
occurs and
DPC isolates the device. I do spot PCI core calling pci_dev_save_and_disable and 
pci_dev_restore
as part of pcie_do_recovery->pci_reset_bus and those functions do store and 
restore the PCI confpsace
but I am not sure this code executes in all cases and 
pcie_do_recovery->pci_reset_bus
was just added now by last sathyanarayanan's patch he gave me anyway...

Andrey


>
> There's lots of state that the PCI core *can't* save/restore, and
> pci_load_saved_state() doesn't even handle all the architected PCI
> state, i.e., we only call pci_add_cap_save_buffer() or
> pci_add_ext_cap_save_buffer() for a few of the capabilities.
