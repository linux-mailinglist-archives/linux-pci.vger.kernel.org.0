Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F336DB4A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhD1PNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 11:13:16 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:19547
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229890AbhD1PNP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 11:13:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7qm3c+yS4Qd4uv/vJZ2PSf6eRayCEmzQXpyyy6bOjucT3YZ63A0ECQ2LTAz6zDMlIOHI8Vgg4sAvb3m+Uip7ZzH/QMeos8jxj/x9X6/FISASnkIfCPsptPGLOWtIyLzSl1bhNE9VnndvVJrvE9PrzB7RCQ5JyeQmsft5Gq4FNuovUM4I8li0LFwMKSADYS+crCygMNdPaCjVUI0BrbLXyq24ld6E7SCW4c4C7JwCNXG37SK9W31HBPwc3eknbICHySD25QnMiCSeCyd85EwgtOdefyjputVgD+qTGbhP+kzCmKNTBqNsltlsa1UPoMpQWSXQbwtceR0aR4L48ummg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl2b5nLE9+Z7+UTpff5mOu1YIPg5KpeHZYXxyFPi2FA=;
 b=exYtpMc58JJ0h0XWONa2od0ErYd1z034ooCGy3neaSNGMuZvMQYLX/5XdjfCgwY+kvZa9kDEcjperJa8nDgMLXvESG1/YjqjCtkbFGgJX4qsJVN2cOmgxx4MxXFEahZ9vMU+PAo/b8xjovMi61XkejWpRx5CRAqRVXKCOVWwE6Xyd5tDf/oVzIkMXFHeCAyxa1/M9ickiwle0LPciCL/+I6w0XurZS6Uaqia84Qqdv35LePh4TJV1V+563/A9CnAb9qe7IqQRtOyhRNiXpil7igpzvI4lR5E6/zP+p/J3SFLzFipwV4Kk6VwuJmmIDGIBOAc7JuGpbVC5Cym++rtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl2b5nLE9+Z7+UTpff5mOu1YIPg5KpeHZYXxyFPi2FA=;
 b=PYQ4Lq4GnJCkyJg2uw4tCaD0EDOhfRisxAr1ALx34uDzUUJmWmueeodhj0VsQHA4Q21PmgL6m0QqpINyDyhPi5UdVuSFWF9yj1sON/469hskwO4dvVtVQhDnpncDxL0cnnuoaS7SNMLeqwRDmmGyQChk+cx7DH3fPZx50dsgL1E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2799.namprd12.prod.outlook.com (2603:10b6:805:77::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Wed, 28 Apr
 2021 15:12:28 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Wed, 28 Apr 2021
 15:12:28 +0000
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH v5 00/27] RFC Support hot device unplug in amdgpu
Date:   Wed, 28 Apr 2021 11:11:40 -0400
Message-Id: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:7212:f93a:73b0:8f23]
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from agrodzovsky-All-Series.hitronhub.home (2607:fea8:3edf:49b0:7212:f93a:73b0:8f23) by YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Wed, 28 Apr 2021 15:12:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51124738-2985-432f-33d5-08d90a580957
X-MS-TrafficTypeDiagnostic: SN6PR12MB2799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB279938C7AAD7644024789784EA409@SN6PR12MB2799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5XcGAizoQKpiR87yVi0Nu417O61K6XrMgHeu+H5xUFptbPS6YIIfsGxsLHus/rnO9SptEBpXeVqGXPM17qySe7Nrz13pba3lfE5P/SnMSZXmPdXHDfFsEHWUprN40ep7WOxVktMeSFmGi7aAUTYsqC/PCqPh7B5snZF7qI+JHBf54O34OJAx/HTabQAWv9JM0wKBqk+XccuWAQtiJA5n2ggFwP8c0tiU0fMh5yW57K8fgGIfVzyp/OAGgLwAp0gII7Qk+JzHYglAvDZvRHIGfLCIxm6QzKMC4+Dnpni30I1sLSF7NMrqR3PNKGYVVelUj3P0wlMPRnKlTiSyihoBdGyXAnfLYnC7xHjl0C2zY8GcjHh3Oila5SP0TAEH06CyOKflkSs9ozXDrV4/vtX6AhHVovWl3Fl8Tkk1PuMVaNWWBgS6s03p+B9BiQ7Pkbo1o4531EZw8YylFZRDt3WtiteG5lsScDTiHEkE+YmEIlt6KWWz6tCaiR2wgYMxsjLXrr/qPgAEuhB/acSVKauj1hhv2h3jn368Cch4oIySgrnSgcoxig6yp5RHxPwAyvLGbC9fZ3K/QQukWxisKeomEg6UQz3QHdqenx1AjrsyMmlatzoU94mV2qGr2DYN0jEJ1YbEURt7TETPJ08SB7s4wWRzBQ2BSw1NtPgoOqjtus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(966005)(16526019)(8676002)(4326008)(478600001)(66556008)(66476007)(2616005)(66946007)(86362001)(44832011)(186003)(83380400001)(36756003)(8936002)(316002)(6666004)(1076003)(6636002)(6506007)(52116002)(38100700002)(30864003)(6512007)(5660300002)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U3AycExiaDRlSG80K20yOGpmM29XSlVKeG03VjlzSkhuWSt4aEd2cjVLOEh3?=
 =?utf-8?B?UDlRQmtsT0JhYmMwck1FNWc5M1pSYXl0bkxSWVFqYzU5SmM1VFpkempnMmV2?=
 =?utf-8?B?ejJBTDNQTXBzd1Azd2xVcnpwSk9YV2ZLc01MT003NmozTExxdDNCd3I3MEVV?=
 =?utf-8?B?dy9NUlFJcVBZeUowTGdremlvejFwU1NDblZ6Vkk5bnNDb3poV2VlSUtCODV0?=
 =?utf-8?B?VnV1aDdsS0pjMDhEZmJLM2MrWG14cnVvQ3RoQ296T0h1OVV0WTRadXBpVEN6?=
 =?utf-8?B?cHpRZ3h5SFcwNld0V3FLRHpydXYxUHR0clUwRENqbGVRb2dJaWRwVHZDc2sw?=
 =?utf-8?B?NHBta20zUTZNTDl6ekRpWjVkMnVhS0Q0NzBNV1N3VjBaNzRqaERlNHpXUnE4?=
 =?utf-8?B?Z2Q1elpKbGdEai8yQVZ2ZW45Q08rbldKVmxCdDdwN0tWTkw1MFJXNzUxSDVP?=
 =?utf-8?B?djY5enFzYzJoRFZYVlpGTHlxZHpMVWhyVFltSDBRcUtNTjlpUUszZTk5a3la?=
 =?utf-8?B?VkZJUk9DdUQxYUhndFpIa3ZzL1IxSDNIeEpkQk93dnc4dk5TaVVQQlg1RWZx?=
 =?utf-8?B?OXF1WDZkSjJ2MlRCeUoydGlienNEV0FMcnFVL0VLWU05N3Y3aDZZSWlPRXBL?=
 =?utf-8?B?WTdoTktMZkpEZFA1dlk2MlpzckJpRGR0NDdDRVlOcTEwa0lYMlNoY01Ec0lR?=
 =?utf-8?B?TUhPQlkvZDFzdmpwbzA0WGl6UnVEcjltYUZ4czV5MVJtdEloY1lEcnV6dGNG?=
 =?utf-8?B?ZFlmTmV4MWRpaTE1RHRneGtEeDdyeGRiYjMreTNpNDhqTmxOY3BTVnZ0c2VM?=
 =?utf-8?B?T1MyYlZCTytoQkRaNFVQOXo4eWphNGp6czRMWU9oTmRaSTAreGJ0T2dBMTVC?=
 =?utf-8?B?UTNKbnAwNlVqZ2NwRmdQTjQyUFM2SCs0Rk0xL3dOQkgzTlJHTWJTTXBBWUZn?=
 =?utf-8?B?QTBsd3RIdTZlWnlkUzh6bFJHeTArTTFieHRhRzhwK091cU9sbHpESnJZZkRq?=
 =?utf-8?B?Y0hKLzNlenUwanMwdGV6bm1CeE0xN1dXUEQvSzdtbm1SSCtQTnBrSFIvMHR4?=
 =?utf-8?B?ZGlSeDBIcXMxa0FWSzBCODRqbVk4akd5QS9KZ0daTkljQlluaU5uckEzSlA3?=
 =?utf-8?B?MTltc2syZUNYamxrc1dnM01nMnJoWVR6b1E5SzNFeXBBcERheXRYdWRnNXNu?=
 =?utf-8?B?MkFSdUdDQmVQdW4rOGdHd0s1TjhqdXhzUFAycEc2clczWEFRbzNwSVZ0a3Vp?=
 =?utf-8?B?VXlhV01ub2g0MnhWdHRjN3RrWUYzamNQbmhaK2Y3SEhjNzNTMHUrYzZwV0Y2?=
 =?utf-8?B?ZUU0ZXBsL0RGaWlrcDVVNnF1M0xxcThUNGg1UkVPK2lqb2FwSkNEZXBoRzRU?=
 =?utf-8?B?N0hFRFY0aGp2VmhDZHBWanZkVlNldkRBTngrZ1d5VW9oZDF0T25zREttbWtK?=
 =?utf-8?B?bGFGbG53b3o2VCt1SXZORkpERUZnTE9uNC9ZR0FIQWJpS3RRM1ExaUtaNzFn?=
 =?utf-8?B?cGFNb2ZUbDZNZU9vQjY1U1JlN3FFQmxYek1oTVdibC9jV3lhSWhPMTlCazJq?=
 =?utf-8?B?aWRQOWNLRDhQcXVPeVlqbmFxLzVFNU9QMHFGRy9FRWkwaGF4dStmWTJnUHVQ?=
 =?utf-8?B?OXpnV2dCZmpMQnM2Y0E2K3BKR2k2NnVQdlFVL3B1QUtPd21HanZ3LzlkUGRE?=
 =?utf-8?B?S1Q0bnB1cGVqT1A5bkg4VHlVdEt2c2lZV3c1Z1p0dEkzQ1dqY0g5NEhGVkFG?=
 =?utf-8?B?SWx2b0c0TTVtUVBZcU1GSW1UZzN1TnpUUGFoRlBZZG9QRkJYZnVRcGp6bEk3?=
 =?utf-8?B?SEJLMG5LOTh1VHRpMG9iR1hIQ0I4SnR1dVJnallheWJDRkZuWDFpYnFVbU9K?=
 =?utf-8?Q?oyY3BijxQCLYm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51124738-2985-432f-33d5-08d90a580957
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 15:12:28.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4OrPw7OwHQhBSR87GBJ9mviGMBO39USZwMOZXFCUIDGYAO29stBL+Z6jax/OHQWEttfTumzACuPD2PA/iTbHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2799
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Until now extracting a card either by physical extraction (e.g. eGPU with 
thunderbolt connection or by emulation through  syfs -> /sys/bus/pci/devices/device_id/remove) 
would cause random crashes in user apps. The random crashes in apps were 
mostly due to the app having mapped a device backed BO into its address 
space was still trying to access the BO while the backing device was gone.
To answer this first problem Christian suggested to fix the handling of mapped 
memory in the clients when the device goes away by forcibly unmap all buffers the 
user processes has by clearing their respective VMAs mapping the device BOs. 
Then when the VMAs try to fill in the page tables again we check in the fault 
handlerif the device is removed and if so, return an error. This will generate a 
SIGBUS to the application which can then cleanly terminate.This indeed was done 
but this in turn created a problem of kernel OOPs were the OOPSes were due to the 
fact that while the app was terminating because of the SIGBUSit would trigger use 
after free in the driver by calling to accesses device structures that were already 
released from the pci remove sequence.This was handled by introducing a 'flush' 
sequence during device removal were we wait for drm file reference to drop to 0 
meaning all user clients directly using this device terminated.

v2:
Based on discussions in the mailing list with Daniel and Pekka [1] and based on the document 
produced by Pekka from those discussions [2] the whole approach with returning SIGBUS and 
waiting for all user clients having CPU mapping of device BOs to die was dropped. 
Instead as per the document suggestion the device structures are kept alive until 
the last reference to the device is dropped by user client and in the meanwhile all existing and new CPU mappings of the BOs 
belonging to the device directly or by dma-buf import are rerouted to per user 
process dummy rw page.Also, I skipped the 'Requirements for KMS UAPI' section of [2] 
since i am trying to get the minimal set of requirements that still give useful solution 
to work and this is the'Requirements for Render and Cross-Device UAPI' section and so my 
test case is removing a secondary device, which is render only and is not involved 
in KMS.

v3:
More updates following comments from v2 such as removing loop to find DRM file when rerouting 
page faults to dummy page,getting rid of unnecessary sysfs handling refactoring and moving 
prevention of GPU recovery post device unplug from amdgpu to scheduler layer. 
On top of that added unplug support for the IOMMU enabled system.

v4:
Drop last sysfs hack and use sysfs default attribute.
Guard against write accesses after device removal to avoid modifying released memory.
Update dummy pages handling to on demand allocation and release through drm managed framework.
Add return value to scheduler job TO handler (by Luben Tuikov) and use this in amdgpu for prevention 
of GPU recovery post device unplug
Also rebase on top of drm-misc-mext instead of amd-staging-drm-next

v5:
The most significant in this series is the improved protection from kernel driver accessing MMIO ranges that were allocated
for the device once the device is gone. To do this, first a patch 'drm/amdgpu: Unmap all MMIO mappings' is introduced.
This patch unamps all MMIO mapped into the kernel address space in the form of BARs and kernel BOs with CPU visible VRAM mappings.
This way it helped to discover multiple such access points because a page fault would be immediately generated on access. Most of them
were solved by moving HW fini code into pci_remove stage (patch drm/amdgpu: Add early fini callback) and for some who 
were harder to unwind drm_dev_enter/exit scoping was used. In addition all the IOCTLs and all background work and timers 
are now protected with drm_dev_enter/exit at their root in an attempt that after drm_dev_unplug is finished none of them 
run anymore and the pci_remove thread is the only thread executing which might touch the HW. To prevent deadlocks in such 
case against threads stuck on various HW or SW fences patches 'drm/amdgpu: Finalise device fences on device remove'  
and drm/amdgpu: Add rw_sem to pushing job into sched queue' take care of force signaling all such existing fences 
and rejecting any newly added ones.

With these patches I am able to gracefully remove the secondary card using sysfs remove hook while glxgears is running off of secondary 
card (DRI_PRIME=1) without kernel oopses or hangs and keep working with the primary card or soft reset the device without hangs or oopses.
Also as per Daniel's comment I added 3 tests to IGT [4] to core_hotunplug test suite - remove device while commands are submitted, 
exported BO and exported fence (not pushed yet).
Also now it's possible to plug back the device after unplug 
Also some users now can successfully use those patches with eGPU boxes[3].




TODOs for followup work:
Convert AMDGPU code to use devm (for hw stuff) and drmm (for sw stuff and allocations) (Daniel)
Add support for 'Requirements for KMS UAPI' section of [2] - unplugging primary, display connected card.

[1] - Discussions during v4 of the patchset https://lists.freedesktop.org/archives/amd-gfx/2021-January/058595.html
[2] - drm/doc: device hot-unplug for userspace https://www.spinics.net/lists/dri-devel/msg259755.html
[3] - Related gitlab ticket https://gitlab.freedesktop.org/drm/amd/-/issues/1081
[4] - https://gitlab.freedesktop.org/agrodzov/igt-gpu-tools/-/commits/master

Andrey Grodzovsky (27):
  drm/ttm: Remap all page faults to per process dummy page.
  drm/ttm: Expose ttm_tt_unpopulate for driver use
  drm/amdgpu: Split amdgpu_device_fini into early and late
  drm/amdkfd: Split kfd suspend from devie exit
  drm/amdgpu: Add early fini callback
  drm/amdgpu: Handle IOMMU enabled case.
  drm/amdgpu: Remap all page faults to per process dummy page.
  PCI: add support for dev_groups to struct pci_device_driver
  dmr/amdgpu: Move some sysfs attrs creation to default_attr
  drm/amdgpu: Guard against write accesses after device removal
  drm/sched: Make timeout timer rearm conditional.
  drm/amdgpu: Prevent any job recoveries after device is unplugged.
  drm/amdgpu: When filizing the fence driver. stop scheduler first.
  drm/amdgpu: Fix hang on device removal.
  drm/scheduler: Fix hang when sched_entity released
  drm/amdgpu: Unmap all MMIO mappings
  drm/amdgpu: Add rw_sem to pushing job into sched queue
  drm/sched: Expose drm_sched_entity_kill_jobs
  drm/amdgpu: Finilise device fences on device remove.
  drm: Scope all DRM IOCTLs  with drm_dev_enter/exit
  drm/amdgpu: Add support for hot-unplug feature at DRM level.
  drm/amd/display: Scope all DM queued work with drm_dev_enter/exit
  drm/amd/powerplay: Scope all PM queued work with drm_dev_enter/exit
  drm/amdkfd: Scope all KFD queued work with drm_dev_enter/exit
  drm/amdgpu: Scope all amdgpu queued work with drm_dev_enter/exit
  drm/amd/display: Remove superflous drm_mode_config_cleanup
  drm/amdgpu: Verify DMA opearations from device are done

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 353 ++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        | 228 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  61 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  33 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |  28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 115 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  56 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  70 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  52 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  74 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  45 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  83 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |  14 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   5 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  44 +--
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   3 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  26 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  22 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   5 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c    |  14 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 124 +++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  24 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  44 ++-
 .../drm/amd/pm/powerplay/smumgr/smu7_smumgr.c |   2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  26 +-
 drivers/gpu/drm/drm_ioctl.c                   |  15 +-
 drivers/gpu/drm/scheduler/sched_entity.c      |   6 +-
 drivers/gpu/drm/scheduler/sched_main.c        |  35 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c               |  79 +++-
 drivers/gpu/drm/ttm/ttm_tt.c                  |   1 +
 drivers/pci/pci-driver.c                      |   1 +
 include/drm/drm_drv.h                         |   6 +
 include/drm/gpu_scheduler.h                   |   1 +
 include/drm/ttm/ttm_bo_api.h                  |   2 +
 include/linux/pci.h                           |   3 +
 64 files changed, 1388 insertions(+), 633 deletions(-)

-- 
2.25.1

