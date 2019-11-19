Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5698B10106C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 02:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKSBEj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 20:04:39 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41253 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfKSBEj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 20:04:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so16339125oty.8
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2019 17:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PHjopbsO7i9SazVony7PNtHssVTo1pTun+TXAOLSAkY=;
        b=YfdVACd+nRWJDV3wKqKzX9TCWj288q9yUITKXoZVOx9ErMhYt/jsPaKI3xQuUOiceS
         D401ZzMXuZiX3t/09aChDMRA1N+4I8quSZq7sdNZIp91Yx0MCBJKgU5wSkzseRBTgmTq
         GN1bk6LLoGaLMgm0H1G6I2xpSAK9m+U/GJD+trvtH0h72z1tjafg6xTeTSoQNO8Dsc5X
         +/ZVG6fWhZdYFrt/PnHvpvIMBi/C1pmq3XD+DBSXMvyxkO6jz3n+S9bBfpVk5RHS5/WD
         66pjTEjWB6+Gu0KwOWBVQZC4KnK04iEVZI2us7Zu7L7jvfjOczz2RfhnoEs9zX68Ze+h
         JJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PHjopbsO7i9SazVony7PNtHssVTo1pTun+TXAOLSAkY=;
        b=eLrg/5FwpNUySGOMiKBgW7awhIR+eKfjL2xS6ewg2V7AKY5EYbiQewkpDdw5y1tNKi
         Re6CusD+kxT4C2wKA4bJ32yrMLc/VvGjxl4GyoJFzMAMX10NH9Er40RDaGSJaCIXtwCF
         QvVpnEnax6wo4FR8fRRHkIYhPuuXx+7P3F1U0e1OERw1JoKQqNhlXlB0L5tKg5oheckD
         061Sn6FuMG2/xuy94Km/i5pzO/223/za0tfPYAAKYXZXOvXA/g/iuep9eshMLlvqVX2F
         eurfYQQI0DM97oE1ANKOSHflyLH/cGV9yrrC42DeB3GUhAXRKipjLBHbhm94Wa4HC89+
         ViOA==
X-Gm-Message-State: APjAAAUsUcGzI9Gwk+z2nuoPeC/voSgFoa07nJzSeODgQom3a/+gzCy7
        czNfW23SD0WBg+akflMZsPSbxA==
X-Google-Smtp-Source: APXvYqxmKP/hRKDvMHBaJCoZMIxgPmOKNQqSs9iNvaOY09s/jjrF09UYznRh0ev+bVy/QdRK7xNeOA==
X-Received: by 2002:a9d:5c83:: with SMTP id a3mr1647749oti.208.1574125474401;
        Mon, 18 Nov 2019 17:04:34 -0800 (PST)
Received: from Fredericks-MacBook-Pro.local ([2600:1700:4870:71e0:c8a4:b0da:bc77:d506])
        by smtp.gmail.com with ESMTPSA id p7sm992694otg.48.2019.11.18.17.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 17:04:33 -0800 (PST)
Subject: Re: [PATCH v2 1/1] drm: Prefer pcie_capability_read_word()
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20191118003513.10852-1-fred@fredlawl.com>
 <CADnq5_PJ+1bPQneqQpyoTGas3Je28SkmQdkMLnBADybMMuJxnQ@mail.gmail.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <53d5ab87-da68-5314-698c-902dd5394f4c@fredlawl.com>
Date:   Mon, 18 Nov 2019 19:04:30 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.18
MIME-Version: 1.0
In-Reply-To: <CADnq5_PJ+1bPQneqQpyoTGas3Je28SkmQdkMLnBADybMMuJxnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Alex Deucher wrote on 11/18/19 11:42 AM:
> On Mon, Nov 18, 2019 at 3:37 AM Frederick Lawler <fred@fredlawl.com> wrote:
>>
>> Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
>> added accessors for the PCI Express Capability so that drivers didn't
>> need to be aware of differences between v1 and v2 of the PCI
>> Express Capability.
>>
>> Replace pci_read_config_word() and pci_write_config_word() calls with
>> pcie_capability_read_word() and pcie_capability_write_word().
>>
>> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
>>
>> ---
>> V2
>> - Squash both drm commits into one
>> - Rebase ontop of d46eac1e658b
>> ---
>>   drivers/gpu/drm/amd/amdgpu/cik.c | 63 ++++++++++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/si.c  | 71 +++++++++++++++++++------------
>>   drivers/gpu/drm/radeon/cik.c     | 70 ++++++++++++++++++------------
>>   drivers/gpu/drm/radeon/si.c      | 73 ++++++++++++++++++++------------
> 
> Can you split this into two patches?  One for amdgpu and one for radeon?
> 
> Thanks!

Sure thing! I also realize I didn't say where the magical commit ref 
came from. It came from Bjorns pci/misc tree. I'll get that out to you 
Wednesday.

> 
> Alex
> 
>>   4 files changed, 174 insertions(+), 103 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
>> index 3067bb874032..f369e3408ed2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>> @@ -1384,7 +1384,6 @@ static int cik_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
>>   static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>>   {
>>          struct pci_dev *root = adev->pdev->bus->self;
>> -       int bridge_pos, gpu_pos;
>>          u32 speed_cntl, current_data_rate;
>>          int i;
>>          u16 tmp16;
>> @@ -1419,12 +1418,7 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>>                  DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
>>          }
>>
>> -       bridge_pos = pci_pcie_cap(root);
>> -       if (!bridge_pos)
>> -               return;
>> -
>> -       gpu_pos = pci_pcie_cap(adev->pdev);
>> -       if (!gpu_pos)
>> +       if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
>>                  return;
>>
>>          if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
>> @@ -1434,14 +1428,17 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>>                          u16 bridge_cfg2, gpu_cfg2;
>>                          u32 max_lw, current_lw, tmp;
>>
>> -                       pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
>> -                       pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
>> +                       pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                 &bridge_cfg);
>> +                       pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
>> +                                                 &gpu_cfg);
>>
>>                          tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
>> -                       pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
>> +                       pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
>>
>>                          tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
>> -                       pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
>> +                       pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
>> +                                                  tmp16);
>>
>>                          tmp = RREG32_PCIE(ixPCIE_LC_STATUS1);
>>                          max_lw = (tmp & PCIE_LC_STATUS1__LC_DETECTED_LINK_WIDTH_MASK) >>
>> @@ -1465,15 +1462,23 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>>
>>                          for (i = 0; i < 10; i++) {
>>                                  /* check status */
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_DEVSTA,
>> +                                                         &tmp16);
>>                                  if (tmp16 & PCI_EXP_DEVSTA_TRPND)
>>                                          break;
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                         &bridge_cfg);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_LNKCTL,
>> +                                                         &gpu_cfg);
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
>> +                                                         &bridge_cfg2);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_LNKCTL2,
>> +                                                         &gpu_cfg2);
>>
>>                                  tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
>>                                  tmp |= PCIE_LC_CNTL4__LC_SET_QUIESCE_MASK;
>> @@ -1486,18 +1491,25 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>>                                  msleep(100);
>>
>>                                  /* linkctl */
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>>                                  tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
>> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
>> +                               pcie_capability_write_word(root, PCI_EXP_LNKCTL,
>> +                                                          tmp16);
>>
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_LNKCTL,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>>                                  tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
>> -                               pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
>> +                               pcie_capability_write_word(adev->pdev,
>> +                                                          PCI_EXP_LNKCTL,
>> +                                                          tmp16);
>>
>>                                  /* linkctl2 */
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN);
>>                                  tmp16 |= (bridge_cfg2 &
>> @@ -1511,7 +1523,9 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>>                                  tmp16 |= (gpu_cfg2 &
>>                                            (PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN));
>> -                               pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
>> +                               pcie_capability_write_word(adev->pdev,
>> +                                                          PCI_EXP_LNKCTL2,
>> +                                                          tmp16);
>>
>>                                  tmp = RREG32_PCIE(ixPCIE_LC_CNTL4);
>>                                  tmp &= ~PCIE_LC_CNTL4__LC_SET_QUIESCE_MASK;
>> @@ -1526,15 +1540,16 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
>>          speed_cntl &= ~PCIE_LC_SPEED_CNTL__LC_FORCE_DIS_SW_SPEED_CHANGE_MASK;
>>          WREG32_PCIE(ixPCIE_LC_SPEED_CNTL, speed_cntl);
>>
>> -       pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +       pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL2, &tmp16);
>>          tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
>> +
>>          if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
>>          else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
>>          else
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
>> -       pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
>> +       pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL2, tmp16);
>>
>>          speed_cntl = RREG32_PCIE(ixPCIE_LC_SPEED_CNTL);
>>          speed_cntl |= PCIE_LC_SPEED_CNTL__LC_INITIATE_LINK_SPEED_CHANGE_MASK;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
>> index a7dcb0d0f039..9f82be879224 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
>> @@ -1633,7 +1633,6 @@ static void si_init_golden_registers(struct amdgpu_device *adev)
>>   static void si_pcie_gen3_enable(struct amdgpu_device *adev)
>>   {
>>          struct pci_dev *root = adev->pdev->bus->self;
>> -       int bridge_pos, gpu_pos;
>>          u32 speed_cntl, current_data_rate;
>>          int i;
>>          u16 tmp16;
>> @@ -1668,12 +1667,7 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
>>                  DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
>>          }
>>
>> -       bridge_pos = pci_pcie_cap(root);
>> -       if (!bridge_pos)
>> -               return;
>> -
>> -       gpu_pos = pci_pcie_cap(adev->pdev);
>> -       if (!gpu_pos)
>> +       if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
>>                  return;
>>
>>          if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
>> @@ -1682,14 +1676,17 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
>>                          u16 bridge_cfg2, gpu_cfg2;
>>                          u32 max_lw, current_lw, tmp;
>>
>> -                       pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
>> -                       pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
>> +                       pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                 &bridge_cfg);
>> +                       pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
>> +                                                 &gpu_cfg);
>>
>>                          tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
>> -                       pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
>> +                       pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
>>
>>                          tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
>> -                       pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
>> +                       pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
>> +                                                  tmp16);
>>
>>                          tmp = RREG32_PCIE(PCIE_LC_STATUS1);
>>                          max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
>> @@ -1706,15 +1703,23 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
>>                          }
>>
>>                          for (i = 0; i < 10; i++) {
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_DEVSTA,
>> +                                                         &tmp16);
>>                                  if (tmp16 & PCI_EXP_DEVSTA_TRPND)
>>                                          break;
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                         &bridge_cfg);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_LNKCTL,
>> +                                                         &gpu_cfg);
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
>> +                                                         &bridge_cfg2);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_LNKCTL2,
>> +                                                         &gpu_cfg2);
>>
>>                                  tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>>                                  tmp |= LC_SET_QUIESCE;
>> @@ -1726,31 +1731,44 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
>>
>>                                  mdelay(100);
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>>                                  tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
>> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
>> +                               pcie_capability_write_word(root, PCI_EXP_LNKCTL,
>> +                                                          tmp16);
>>
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_LNKCTL,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>>                                  tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
>> -                               pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
>> +                               pcie_capability_write_word(adev->pdev,
>> +                                                          PCI_EXP_LNKCTL,
>> +                                                          tmp16);
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN);
>>                                  tmp16 |= (bridge_cfg2 &
>>                                            (PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN));
>> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
>> +                               pcie_capability_write_word(root,
>> +                                                          PCI_EXP_LNKCTL2,
>> +                                                          tmp16);
>>
>> -                               pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +                               pcie_capability_read_word(adev->pdev,
>> +                                                         PCI_EXP_LNKCTL2,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN);
>>                                  tmp16 |= (gpu_cfg2 &
>>                                            (PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN));
>> -                               pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
>> +                               pcie_capability_write_word(adev->pdev,
>> +                                                          PCI_EXP_LNKCTL2,
>> +                                                          tmp16);
>>
>>                                  tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>>                                  tmp &= ~LC_SET_QUIESCE;
>> @@ -1763,15 +1781,16 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
>>          speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
>>          WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
>>
>> -       pci_read_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +       pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL2, &tmp16);
>>          tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
>> +
>>          if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
>>          else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
>>          else
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
>> -       pci_write_config_word(adev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
>> +       pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL2, tmp16);
>>
>>          speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
>>          speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
>> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
>> index a280442c81aa..09a4709e67f0 100644
>> --- a/drivers/gpu/drm/radeon/cik.c
>> +++ b/drivers/gpu/drm/radeon/cik.c
>> @@ -9504,7 +9504,6 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>>   {
>>          struct pci_dev *root = rdev->pdev->bus->self;
>>          enum pci_bus_speed speed_cap;
>> -       int bridge_pos, gpu_pos;
>>          u32 speed_cntl, current_data_rate;
>>          int i;
>>          u16 tmp16;
>> @@ -9546,12 +9545,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>>                  DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
>>          }
>>
>> -       bridge_pos = pci_pcie_cap(root);
>> -       if (!bridge_pos)
>> -               return;
>> -
>> -       gpu_pos = pci_pcie_cap(rdev->pdev);
>> -       if (!gpu_pos)
>> +       if (!pci_is_pcie(root) || !pci_is_pcie(rdev->pdev))
>>                  return;
>>
>>          if (speed_cap == PCIE_SPEED_8_0GT) {
>> @@ -9561,14 +9555,17 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>>                          u16 bridge_cfg2, gpu_cfg2;
>>                          u32 max_lw, current_lw, tmp;
>>
>> -                       pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
>> -                       pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
>> +                       pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                 &bridge_cfg);
>> +                       pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL,
>> +                                                 &gpu_cfg);
>>
>>                          tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
>> -                       pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
>> +                       pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
>>
>>                          tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
>> -                       pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
>> +                       pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL,
>> +                                                  tmp16);
>>
>>                          tmp = RREG32_PCIE_PORT(PCIE_LC_STATUS1);
>>                          max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
>> @@ -9586,15 +9583,23 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>>
>>                          for (i = 0; i < 10; i++) {
>>                                  /* check status */
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_DEVSTA,
>> +                                                         &tmp16);
>>                                  if (tmp16 & PCI_EXP_DEVSTA_TRPND)
>>                                          break;
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                         &bridge_cfg);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_LNKCTL,
>> +                                                         &gpu_cfg);
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
>> +                                                         &bridge_cfg2);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_LNKCTL2,
>> +                                                         &gpu_cfg2);
>>
>>                                  tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>>                                  tmp |= LC_SET_QUIESCE;
>> @@ -9607,32 +9612,45 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>>                                  msleep(100);
>>
>>                                  /* linkctl */
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>>                                  tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
>> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
>> +                               pcie_capability_write_word(root, PCI_EXP_LNKCTL,
>> +                                                          tmp16);
>>
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_LNKCTL,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>>                                  tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
>> -                               pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
>> +                               pcie_capability_write_word(rdev->pdev,
>> +                                                          PCI_EXP_LNKCTL,
>> +                                                          tmp16);
>>
>>                                  /* linkctl2 */
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN);
>>                                  tmp16 |= (bridge_cfg2 &
>>                                            (PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN));
>> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
>> +                               pcie_capability_write_word(root,
>> +                                                          PCI_EXP_LNKCTL2,
>> +                                                          tmp16);
>>
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_LNKCTL2,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN);
>>                                  tmp16 |= (gpu_cfg2 &
>>                                            (PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN));
>> -                               pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
>> +                               pcie_capability_write_word(rdev->pdev,
>> +                                                          PCI_EXP_LNKCTL2,
>> +                                                          tmp16);
>>
>>                                  tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>>                                  tmp &= ~LC_SET_QUIESCE;
>> @@ -9646,7 +9664,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>>          speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
>>          WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
>>
>> -       pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +       pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL2, &tmp16);
>>          tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
>>          if (speed_cap == PCIE_SPEED_8_0GT)
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
>> @@ -9654,7 +9672,7 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
>>          else
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
>> -       pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
>> +       pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL2, tmp16);
>>
>>          speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
>>          speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
>> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
>> index 529e70a42019..67a98b3370d1 100644
>> --- a/drivers/gpu/drm/radeon/si.c
>> +++ b/drivers/gpu/drm/radeon/si.c
>> @@ -3257,7 +3257,7 @@ static void si_gpu_init(struct radeon_device *rdev)
>>                  /* XXX what about 12? */
>>                  rdev->config.si.tile_config |= (3 << 0);
>>                  break;
>> -       }
>> +       }
>>          switch ((mc_arb_ramcfg & NOOFBANK_MASK) >> NOOFBANK_SHIFT) {
>>          case 0: /* four banks */
>>                  rdev->config.si.tile_config |= 0 << 4;
>> @@ -7087,7 +7087,6 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>>   {
>>          struct pci_dev *root = rdev->pdev->bus->self;
>>          enum pci_bus_speed speed_cap;
>> -       int bridge_pos, gpu_pos;
>>          u32 speed_cntl, current_data_rate;
>>          int i;
>>          u16 tmp16;
>> @@ -7129,12 +7128,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>>                  DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
>>          }
>>
>> -       bridge_pos = pci_pcie_cap(root);
>> -       if (!bridge_pos)
>> -               return;
>> -
>> -       gpu_pos = pci_pcie_cap(rdev->pdev);
>> -       if (!gpu_pos)
>> +       if (!pci_is_pcie(root) || !pci_is_pcie(rdev->pdev))
>>                  return;
>>
>>          if (speed_cap == PCIE_SPEED_8_0GT) {
>> @@ -7144,14 +7138,17 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>>                          u16 bridge_cfg2, gpu_cfg2;
>>                          u32 max_lw, current_lw, tmp;
>>
>> -                       pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
>> -                       pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
>> +                       pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                 &bridge_cfg);
>> +                       pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL,
>> +                                                 &gpu_cfg);
>>
>>                          tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
>> -                       pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
>> +                       pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
>>
>>                          tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
>> -                       pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
>> +                       pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL,
>> +                                                  tmp16);
>>
>>                          tmp = RREG32_PCIE(PCIE_LC_STATUS1);
>>                          max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
>> @@ -7169,15 +7166,23 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>>
>>                          for (i = 0; i < 10; i++) {
>>                                  /* check status */
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_DEVSTA, &tmp16);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_DEVSTA,
>> +                                                         &tmp16);
>>                                  if (tmp16 & PCI_EXP_DEVSTA_TRPND)
>>                                          break;
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &bridge_cfg);
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &gpu_cfg);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                         &bridge_cfg);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_LNKCTL,
>> +                                                         &gpu_cfg);
>>
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &bridge_cfg2);
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &gpu_cfg2);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
>> +                                                         &bridge_cfg2);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_LNKCTL2,
>> +                                                         &gpu_cfg2);
>>
>>                                  tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>>                                  tmp |= LC_SET_QUIESCE;
>> @@ -7190,32 +7195,46 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>>                                  msleep(100);
>>
>>                                  /* linkctl */
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL, &tmp16);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>>                                  tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
>> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL, tmp16);
>> +                               pcie_capability_write_word(root,
>> +                                                          PCI_EXP_LNKCTL,
>> +                                                          tmp16);
>>
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, &tmp16);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_LNKCTL,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
>>                                  tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
>> -                               pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL, tmp16);
>> +                               pcie_capability_write_word(rdev->pdev,
>> +                                                          PCI_EXP_LNKCTL,
>> +                                                          tmp16);
>>
>>                                  /* linkctl2 */
>> -                               pci_read_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +                               pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN);
>>                                  tmp16 |= (bridge_cfg2 &
>>                                            (PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN));
>> -                               pci_write_config_word(root, bridge_pos + PCI_EXP_LNKCTL2, tmp16);
>> +                               pcie_capability_write_word(root,
>> +                                                          PCI_EXP_LNKCTL2,
>> +                                                          tmp16);
>>
>> -                               pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +                               pcie_capability_read_word(rdev->pdev,
>> +                                                         PCI_EXP_LNKCTL2,
>> +                                                         &tmp16);
>>                                  tmp16 &= ~(PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN);
>>                                  tmp16 |= (gpu_cfg2 &
>>                                            (PCI_EXP_LNKCTL2_ENTER_COMP |
>>                                             PCI_EXP_LNKCTL2_TX_MARGIN));
>> -                               pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
>> +                               pcie_capability_write_word(rdev->pdev,
>> +                                                          PCI_EXP_LNKCTL2,
>> +                                                          tmp16);
>>
>>                                  tmp = RREG32_PCIE_PORT(PCIE_LC_CNTL4);
>>                                  tmp &= ~LC_SET_QUIESCE;
>> @@ -7229,7 +7248,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>>          speed_cntl &= ~LC_FORCE_DIS_SW_SPEED_CHANGE;
>>          WREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL, speed_cntl);
>>
>> -       pci_read_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, &tmp16);
>> +       pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL2, &tmp16);
>>          tmp16 &= ~PCI_EXP_LNKCTL2_TLS;
>>          if (speed_cap == PCIE_SPEED_8_0GT)
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_8_0GT; /* gen3 */
>> @@ -7237,7 +7256,7 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_5_0GT; /* gen2 */
>>          else
>>                  tmp16 |= PCI_EXP_LNKCTL2_TLS_2_5GT; /* gen1 */
>> -       pci_write_config_word(rdev->pdev, gpu_pos + PCI_EXP_LNKCTL2, tmp16);
>> +       pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL2, tmp16);
>>
>>          speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
>>          speed_cntl |= LC_INITIATE_LINK_SPEED_CHANGE;
>> --
>> 2.20.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


Thanks,
Frederick Lawler

