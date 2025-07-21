Return-Path: <linux-pci+bounces-32668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A48AB0C83D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEFF1C2167F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DE2E11A8;
	Mon, 21 Jul 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCfYLxVG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577872E092A
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113184; cv=none; b=RjxefEyJ3MEKr5gmgTs852uHcjAZnXa34KOOPrc7RBzuS7SWtQIFCMl96F02jomE1phf5AI6VOSJPUHCLZmlLzdWD+p1ARUOi0U6Chvg45BsBWbGmeYw5a0EbBENS4Tr8QSg3N1XPLd9Cg5TlM/AhWSdeKTrphgAVzjcC4f3PEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113184; c=relaxed/simple;
	bh=Tru6mUU+iCCDap926QFI/QE8fHmIDFa7JUWzEQ9+meA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIkPsQKt+TGLler7GD5iHLLtDCRgmzXWUlNsbiJ7rCgmjcIBJC9w3DRFJW3vVapmGKV42wYpu1R8Zwhe+gxcQpRVAVv2wbXNDyuXMUzZaUDsN1XSpWMfCbZrpGuxoJswZJS7J+JH3EnQMUr6+ur2u2GSoGpWnXxD69rSATBo7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCfYLxVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A2CC4CEED;
	Mon, 21 Jul 2025 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753113183;
	bh=Tru6mUU+iCCDap926QFI/QE8fHmIDFa7JUWzEQ9+meA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VCfYLxVGU3pdYqZsnYkKwCVVy0tE0t2JupJaTxLkysPFPr28Mkz9KbdSSo93tHqqi
	 isIPw49RNTT9PEYvCZ9IfgRwuQhvYcxQeSvuBECchF/YXUoE5iy/iQiMowGs4JaWEr
	 jS0I2BwPcXKj4XnMklK+Gza98Sl3raxBbrQIfJX0ntU0uUT400zLT7ttcIoFO8Qe6Z
	 qyTV5rUVHIW/0m6cYoPOG+VVcc+7FxdwKb7y+9O4Mjt9Yen4NXY1UIqqlenX/qeZ6R
	 VhwafLTR3Lf/xlWKCnECNAoximcEciMhZ0lQQqW8yldlTBzHXdQDSXVzVRLOgR0gOc
	 MB9Sh147B0l4A==
Message-ID: <c9e31945-e00d-409c-987b-ddf8395b52ad@kernel.org>
Date: Mon, 21 Jul 2025 10:53:02 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix warning without CONFIG_VIDEO
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org
References: <20250718134134.1710578-1-superm1@kernel.org>
 <rdqrqwoye3b4tut4mgqckshmlslycg2weyleasduxawhyoifq6@pyykudf4ncke>
 <b15cf1f2-7155-413a-973a-d632e5170596@kernel.org>
 <hwdswlzbejlrawrrsgdlqtmzb6437kyei4hl5uqpe24orey2qd@2u7i7dzkhfyu>
 <ca34c473-579b-4991-984d-4e037005c979@kernel.org>
 <5gthsstizscrujhx46ybngtuny2lafmjwaidykn4rbvi6lr2by@jnuryin54ghx>
 <793a0872-37a8-4fe7-bf68-b9072d7a6aec@kernel.org>
 <zvpa4rrhfgpnjdfk2e64qaneoavjs4hqe5a7zqnhtddprnvkbr@viutp5nqevnh>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <zvpa4rrhfgpnjdfk2e64qaneoavjs4hqe5a7zqnhtddprnvkbr@viutp5nqevnh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/25 3:00 AM, Manivannan Sadhasivam wrote:
> On Sat, Jul 19, 2025 at 08:46:04AM GMT, Mario Limonciello wrote:
>>
>>
>> On 7/18/25 9:47 PM, Manivannan Sadhasivam wrote:
>>> On Fri, Jul 18, 2025 at 12:26:49PM GMT, Mario Limonciello wrote:
>>>> On 7/18/2025 12:23 PM, Manivannan Sadhasivam wrote:
>>>>> On Fri, Jul 18, 2025 at 12:06:22PM GMT, Mario Limonciello wrote:
>>>>>> On 7/18/2025 12:00 PM, Manivannan Sadhasivam wrote:
>>>>>>> On Fri, Jul 18, 2025 at 08:41:33AM GMT, Mario Limonciello wrote:
>>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>>
>>>>>>>> When compiled without CONFIG_VIDEO pci_create_boot_display_file() will
>>>>>>>> never create a sysfs file for boot_display. Guard the sysfs file
>>>>>>>> declaration against CONFIG_VIDEO.
>>>>>>>>
>>>>>>>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>>>>>>> Closes: https://lore.kernel.org/linux-next/20250718224118.5b3f22b0@canb.auug.org.au/
>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/pci/pci-sysfs.c | 2 ++
>>>>>>>>      1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>>>>>> index 6b1a0ae254d3a..f6540a72204d3 100644
>>>>>>>> --- a/drivers/pci/pci-sysfs.c
>>>>>>>> +++ b/drivers/pci/pci-sysfs.c
>>>>>>>> @@ -680,12 +680,14 @@ const struct attribute_group *pcibus_groups[] = {
>>>>>>>>      	NULL,
>>>>>>>>      };
>>>>>>>> +#ifdef CONFIG_VIDEO
>>>>>>>>      static ssize_t boot_display_show(struct device *dev, struct device_attribute *attr,
>>>>>>>>      				 char *buf)
>>>>>>>>      {
>>>>>>>>      	return sysfs_emit(buf, "1\n");
>>>>>>>>      }
>>>>>>>>      static DEVICE_ATTR_RO(boot_display);
>>>>>>>
>>>>>>> I failed to give my comment during the offending series itself, but it is never
>>>>>>> late than never. Why are we adding non-PCI attributes under bus/pci in the first
>>>>>>> place? Though the underlying device uses PCI as a transport, only the PCI bus
>>>>>>> specific attrbutes should be placed under bus/pci and the driver/peripheral
>>>>>>> specific attrbutes should belong to the respective bus/class/device hierarchy.
>>>>>>>
>>>>>>> Now, if other peripherals (like netdev) start adding these device specific
>>>>>>> attributes under bus/pci, it will turn out to be a mess.
>>>>>>>
>>>>>>> - Mani
>>>>>>>
>>>>>>
>>>>>> It was mostly to mirror the location of where boot_vga is, which arguably
>>>>>> has the same issue you raise.
>>>>>>
>>>>>
>>>>> Yes, I agree. But 'boot_vga' has set a bad precedence IMO.
>>>>>
>>>>>> I would be incredibly surprised if there was a proposal to add a
>>>>>> 'boot_display' attribute from netdev..
>>>>>
>>>>> Not 'boot_display' but why not 'boot_network' or something else. I was just
>>>>> merely pointing out the fact that the other subsystems can start dumping
>>>>> device/usecase specific attributes under bus/pci.
>>>>>
>>>>> - Mani
>>>>>
>>>>
>>>> This is a pretty general problem that exists that attributes are first come
>>>> first served.  For example amdgpu adds mem_busy_percent and it has certain
>>>> semantics.  Now PCI core can't add that.
>>>>
>>>> And if nouveau.ko wants to add the same thing they need to follow the same
>>>> semantics because userspace will look for those.
>>>
>>> But here, userspace is not yet looking for 'boot_display' isn't it? Why do you
>>> need to mirror 'boot_vga' attribute?
>>>
>>
>> I have a pull request opened in libpciaccess; but correct it has not been
>> merged.
>>
>> /If/ we're to change this, what would you propose the path to be for this
>> sysfs file?
> 
> Obviously, DRM.
> 
> - Mani
> 

The problem is sysfs for drm is oriented around connectors.
This is definitely not a connector, it's a property of the device itself.

❯ cd /sys/class/drm/
❯ ls
lrwxrwxrwx    - root 21 Jul 10:41  card0 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-1 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-1
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-2 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-2
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-3 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-3
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-4 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-4
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-5 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-5
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-6 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-6
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-7 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-7
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-8 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-8
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-9 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-9
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-10 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-10
lrwxrwxrwx    - root 21 Jul 10:41  card0-DP-11 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-DP-11
lrwxrwxrwx    - root 21 Jul 10:41  card0-HDMI-A-1 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-HDMI-A-1
lrwxrwxrwx    - root 21 Jul 10:41  card0-Writeback-1 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/card0/card0-Writeback-1
lrwxrwxrwx    - root 21 Jul 10:41  renderD128 -> 
../../devices/pci0000:00/0000:00:08.1/0000:c2:00.0/drm/renderD128
.r--r--r-- 4.1k root 21 Jul 10:41 󰡯 version
❯ cat version
drm 1.1.0 20060810
❯ cd card0
❯ ls
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-1
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-2
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-3
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-4
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-5
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-6
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-7
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-8
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-9
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-10
drwxr-xr-x    - root 21 Jul 08:14  card0-DP-11
drwxr-xr-x    - root 21 Jul 08:14  card0-HDMI-A-1
drwxr-xr-x    - root 21 Jul 08:14  card0-Writeback-1
lrwxrwxrwx    - root 21 Jul 08:14  device -> ../../../0000:c2:00.0
drwxr-xr-x    - root 21 Jul 08:14  power
lrwxrwxrwx    - root 21 Jul 08:14  subsystem -> ../../../../../../class/drm
.r--r--r-- 4.1k root 21 Jul 08:14 󰡯 dev
.rw-r--r-- 4.1k root 21 Jul 08:14 󰡯 uevent

If you look at the device you can see there are dozens of properties for 
the device at the device folder that come from all different parts of 
the stack that populate them.

❯ cd device
❯ ls
lrwxrwxrwx    - root 16 Jul 11:34  consumer:pci:0000:c2:00.1 -> 
../../../virtual/devlink/pci:0000:c2:00.0--pci:0000:c2:00.1
lrwxrwxrwx    - root 16 Jul 11:34  driver -> 
../../../../bus/pci/drivers/amdgpu
drwxr-xr-x    - root 16 Jul 11:34  drm
lrwxrwxrwx    - root 16 Jul 11:34  firmware_node -> 
../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:18/LNXVIDEO:00
drwxr-xr-x    - root 16 Jul 11:34  fw_version
drwxr-xr-x    - root 16 Jul 11:34  graphics
drwxr-xr-x    - root 16 Jul 11:34  hwmon
drwxr-xr-x    - root 16 Jul 11:34  i2c-0
drwxr-xr-x    - root 16 Jul 11:34  i2c-1
drwxr-xr-x    - root 16 Jul 11:34  i2c-2
drwxr-xr-x    - root 16 Jul 11:34  i2c-3
drwxr-xr-x    - root 16 Jul 11:34  i2c-4
drwxr-xr-x    - root 16 Jul 11:34  i2c-5
drwxr-xr-x    - root 16 Jul 11:34  i2c-6
drwxr-xr-x    - root 16 Jul 11:34  i2c-7
drwxr-xr-x    - root 16 Jul 11:34  i2c-8
drwxr-xr-x    - root 16 Jul 11:34  i2c-17
drwxr-xr-x    - root 16 Jul 11:34  i2c-18
lrwxrwxrwx    - root 16 Jul 11:34  iommu -> ../../0000:00:00.2/iommu/ivhd0
lrwxrwxrwx    - root 16 Jul 11:34  iommu_group -> 
../../../../kernel/iommu_groups/19
drwxr-xr-x    - root 16 Jul 11:34  ip_discovery
drwxr-xr-x    - root 16 Jul 11:34  link
drwxr-xr-x    - root 16 Jul 11:34  msi_irqs
drwxr-xr-x    - root 16 Jul 11:34  power
lrwxrwxrwx    - root 16 Jul 11:34  subsystem -> ../../../../bus/pci
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 ari_enabled
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 broken_parity_status
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 class
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 compute_reset_mask
.rw-r--r-- 4.1k root 16 Jul 11:34 󱁻 config
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 consistent_dma_mask_bits
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 current_link_speed
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 current_link_width
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 d3cold_allowed
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 device
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 dma_mask_bits
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 driver_override
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 enable
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 enforce_isolation
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 gfx_reset_mask
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 gpu_busy_percent
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 gpu_metrics
.rw-rw-r-- 5.1k root 16 Jul 11:34 󰡯 hdcp_srm
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 irq
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 jpeg_reset_mask
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 local_cpulist
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 local_cpus
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 max_link_speed
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 max_link_width
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 mem_info_gtt_total
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 mem_info_gtt_used
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 mem_info_preempt_used
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 mem_info_vis_vram_total
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 mem_info_vis_vram_used
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 mem_info_vram_total
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 mem_info_vram_used
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 modalias
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 msi_bus
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 numa_node
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 pcie_replay_count
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 power_dpm_force_performance_level
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 power_dpm_state
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 power_state
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_cur_state
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_dpm_dcefclk
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_dpm_fclk
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_dpm_mclk
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_dpm_pcie
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_dpm_sclk
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_dpm_socclk
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_force_state
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_num_states
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_od_clk_voltage
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 pp_table
.-w--w---- 4.1k root 16 Jul 11:34 󰡯 remove
.-w------- 4.1k root 16 Jul 11:34 󰡯 rescan
.-w------- 4.1k root 16 Jul 11:34 󰡯 reset
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 reset_method
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 resource
.rw------- 8.6G root 16 Jul 11:34 󰡯 resource0
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 resource0_resize
.rw------- 8.6G root 16 Jul 11:34 󰡯 resource0_wc
.rw------- 268M root 16 Jul 11:34 󰡯 resource2
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 resource2_resize
.rw------- 268M root 16 Jul 11:34 󰡯 resource2_wc
.rw-------  256 root 16 Jul 11:34 󰡯 resource4
.rw------- 1.0M root 16 Jul 11:34 󰡯 resource5
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 revision
.-w------- 4.1k root 16 Jul 11:34 󰡯 run_cleaner_shader
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 sdma_reset_mask
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 subsystem_device
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 subsystem_vendor
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 thermal_throttling_logging
.rw-r--r-- 4.1k root 16 Jul 11:34 󰡯 uevent
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 vbios_version
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 vcn_busy_percent
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 vendor
.r--r--r-- 4.1k root 16 Jul 11:34 󰡯 vpe_reset_mask

