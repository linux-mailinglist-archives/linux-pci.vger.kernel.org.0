Return-Path: <linux-pci+bounces-18416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D69F1917
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 23:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8491618D0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BD8194A45;
	Fri, 13 Dec 2024 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="cHm7rJzR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660562AD14;
	Fri, 13 Dec 2024 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128803; cv=none; b=E9d9s4JTaSmY9Lias70Wd5RSiAuoC9GMA1QSC6OzMkfR+yD6IkLneuL44abSiViUW/h8FG22hzRl+iKgVzcPF4melXcxdE3MfgIzfXByJB8He2SO3ibVC582QWzO8+oMbzQJhihLfcMJuMGh2eWP8nYHuTR2672i7qJaJ9a+ikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128803; c=relaxed/simple;
	bh=cNWs3RkfxS5P9y2IEQPaT9P93dW8ZS9inWQjwQzJ8DQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=K4dxruCLdpKRXjZtsmLt9YpJPyemxllHzsyYLFwizmu0o4GofCwa/WB+0K4AFRaq+szR88kj5gddhZoaje1Gz+2G4CphP9KIGDRunGxfKCuaUsxGsSsA+yg0rOvYY96ogAGXD2K1scnVcsgPp44bqdezqq9XAyt41l6l9scMZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=cHm7rJzR; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Y93pk2Zsxz16Gj;
	Fri, 13 Dec 2024 17:26:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1734128799; bh=cNWs3RkfxS5P9y2IEQPaT9P93dW8ZS9inWQjwQzJ8DQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cHm7rJzReRqJJ/CGg5vgOCeDeDiNGXf1r63Cy027B/0NTVNRYWkXVDoidUGoP5cU2
	 wfqXfZpY9P8ii2QwpbeocM+jQ06MHb8Z8jWol0h8egzc3RPBMm3msxdY8AyElfTEId
	 8zTwZd2fkAVIlLxA2uvZ9e8xYCK2rED7P3CEHUNg=
Content-Type: multipart/mixed; boundary="------------qNaSdL5oAfEZidOA7wn4C39v"
Message-ID: <0f708fdf-ca54-488f-8c7e-160c1164308a@panix.com>
Date: Fri, 13 Dec 2024 14:26:37 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>,
 Nirmal Patel <nirmal.patel@linux.ntel.com>, Kenneth Crudup <kenny@panix.com>
References: <20241213164335.GA3381091@bhelgaas>
 <66843f3e-e8f9-40e6-8f7e-a332ff386fe7@panix.com>
 <ff7abb52-fb53-40ce-bef5-50540d6b9512@panix.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <ff7abb52-fb53-40ce-bef5-50540d6b9512@panix.com>

This is a multi-part message in MIME format.
--------------qNaSdL5oAfEZidOA7wn4C39v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


OK, it looks like the effective change (that's not already contained in 
the LTR SNOOP patches already in Linus' master (et al.)) comes from this 
line from the Ubuntu commit 1a0102a0 ("UBUNTU: SAUCE: PCI/ASPM: Enable 
ASPM for links under VMD domain"):

----
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 00143f5fb83a..d2ff44e7fbb1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -688,7 +688,8 @@ static void pcie_aspm_cap_init(struct 
pcie_link_state *link, int blacklist)
         aspm_l1ss_init(link);

         /* Save default state */
-       link->aspm_default = link->aspm_enabled;
+       link->aspm_default = parent->dev_flags & PCI_DEV_FLAGS_ENABLE_ASPM ?
+                            ASPM_STATE_ALL : link->aspm_enabled;
----

Where "PCI_DEV_FLAGS_ENABLE_ASPM" (a new flag) is set if the parent 
bridge is a VMD (determined via Ubuntu commit 154d48da2 ("UBUNTU: SAUCE: 
vmd: fixup bridge ASPM by driver name instead").

So, as we've both noticed, most of the three patches I'd pointed out 
aren't required as the LTR SNOOP values are either fixed up, or 
previously set in the BIOS.

So I've folded the new commits into the attached patch (against Linus' 
master), which now gives me full power-saving.

-K


On 12/13/24 12:27, Kenneth Crudup wrote:
> 
> Turns out that my current VMD is already listed as "VMD_FEATS_CLIENT" 
> after all:
> 
> ----
>          {PCI_VDEVICE(INTEL, 0x467f),
>                  .driver_data = VMD_FEATS_CLIENT,},
> ----
> 0000:00:0e.0 0104: 8086:467f
>          Subsystem: 1028:0af3
>          Flags: bus master, fast devsel, latency 0, IOMMU group 9
>          Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
>          Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
>          Memory at 6040100000 (64-bit, non-prefetchable) [size=1M]
>          Capabilities: [80] MSI-X: Enable+ Count=19 Masked-
>          Capabilities: [90] Express Root Complex Integrated Endpoint, 
> MSI 00
>          Capabilities: [e0] Power Management version 3
>          Kernel driver in use: vmd
> ----
> 
> I'm going to compare the commits you'd pointed out in master to what the 
> working (Ubuntu) patches do and figure out where the disconnect is.
> 
> -K
> 
> On 12/13/24 11:48, Kenneth Crudup wrote:
>>
>> I was really hopeful this would have handled it, but no joy.
>>
>> I also tried dropping "PCI/ASPM: Enable LTR for endpoints behind VMD" 
>> and "PCI/ASPM: Enable ASPM for links under VMD domain" each separately 
>> on top of the below quirk patch to no avail.
>>
>> The only thing that works is the aggregate patch I've added.
>>
>>  > However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
>>  > VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
>>  > so I'd be surprised if VMD worked for those devices unless BIOS set
>>  > up the VMD itself.
>>
>> Yeah, my BIOS does- not sure if you'd missed it, but I'd rewritten 
>> "Enable LTR for endpoints behind VMD" to print if the BIOS already 
>> does that for you, and sent the patch here (since I wasn't seeing the 
>> message printed when the fixup was being done and wanted to know why).
>>
>> I'd REALLY like to get this into mainline, so if there's anything I 
>> can do to help, LMK.
>>
>> Thanks,
>> -Kenny
>>
>>
>> On 12/13/24 08:43, Bjorn Helgaas wrote:
>>> [+cc David, Nirmal, linux-pci]
>>>
>>> On Thu, Dec 12, 2024 at 03:04:53PM -0800, Kenneth Crudup wrote:
>>>> On 12/12/24 12:56, Bjorn Helgaas wrote:
>>>>> On Wed, Dec 11, 2024 at 03:26:37PM -0800, Kenneth Crudup wrote:
>>>>>> So we're on 6.13-rc2 and the patches are getting closer and
>>>>>> closer, but they still need to be manually added.
>>>>>>
>>>>>> The good news is now only (variants of) "PCI/ASPM: Enable LTR
>>>>>> for endpoints behind VMD" and "PCI/ASPM: Enable ASPM for links
>>>>>> under VMD domain" are needed.
>>>> ...
>>>
>>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>>> lunar/commit/?id=47c7bfd31514e7b54a1f830f7707297aebbb8679
>>>
>>> This is "UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind
>>> VMD", which writes PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT
>>> for PCI_CLASS_STORAGE_EXPRESS devices directly below VMDs with Device
>>> IDs 0x9a09, 0xa0b0, or 0xa0bc.
>>>
>>> This looks equivalent in spirit to upstream
>>> https://git.kernel.org/linus/f492edb40b54 ("PCI: vmd: Add quirk to
>>> configure PCIe ASPM and LTR"), which writes PCI_LTR_MAX_SNOOP_LAT and
>>> PCI_LTR_MAX_NOSNOOP_LAT for any kind of device below VMDs tagged with
>>> VMD_FEATS_CLIENT, which includes 0x467f, 0x4c3d, 0x7d0b, 0x9a0b,
>>> 0xa77f, 0xad0b, 0xb06f, 0xb60b.
>>>
>>> However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
>>> VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
>>> so I'd be surprised if VMD worked for those devices unless BIOS set
>>> up the VMD itself.
>>>
>>> Maybe David or Nirmal can comment on this?
>>>
>>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>>> lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c878b5526
>>>
>>> This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
>>> domain", which adds "link->aspm_default = ASPM_STATE_ALL" for device
>>> IDs 0x9a09 and 0xa0b0.
>>>
>>> This looks like it should also be handled by upstream f492edb40b54
>>> ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], which adds
>>> "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".
>>>
>>> But again, the Device IDs mentioned in the Ubuntu commit are NOT
>>> included in the upstream VMD_FEATS_CLIENT list.
>>>
>>>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/ 
>>>> lunar/commit/?id=154d48da2c57514e4b5dadc7b8c70a4edb550981
>>>
>>> This is "UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name
>>> instead", which applies the quirk that writes PCI_LTR_MAX_SNOOP_LAT
>>> and PCI_LTR_MAX_NOSNOOP_LAT for PCI_CLASS_STORAGE_EXPRESS devices
>>> below any VMD claimed by the "vmd" driver, not just VMDs with Device
>>> IDs 0x9a09, 0xa0b0, or 0xa0bc.
>>>
>>> I think the only thing that's missing is that the upstream vmd_ids[]
>>> needs to be updated with some new VMD Device IDs that are tagged with
>>> VMD_FEATS_CLIENT.
>>>
>>> I don't know what the vmd_ids[] strategy is, but Kenneth, you might
>>> try an upstream patch like the one below.  If that resolves the
>>> standby/low-power issues, maybe David or Nirmal can figure out the
>>> "right" way to do this.
>>>
>>> Bjorn
>>>
>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>> index 9d9596947350..4de7ff3bbf23 100644
>>> --- a/drivers/pci/controller/vmd.c
>>> +++ b/drivers/pci/controller/vmd.c
>>> @@ -1109,6 +1109,12 @@ static const struct pci_device_id vmd_ids[] = {
>>>                   .driver_data = VMD_FEATS_CLIENT,},
>>>       {PCI_VDEVICE(INTEL, 0xb06f),
>>>                   .driver_data = VMD_FEATS_CLIENT,},
>>> +    {PCI_VDEVICE(INTEL, 0x9a09),
>>> +                .driver_data = VMD_FEATS_CLIENT,},
>>> +    {PCI_VDEVICE(INTEL, 0xa0b0),
>>> +                .driver_data = VMD_FEATS_CLIENT,},
>>> +    {PCI_VDEVICE(INTEL, 0xa0bc),
>>> +                .driver_data = VMD_FEATS_CLIENT,},
>>>       {0,}
>>>   };
>>>   MODULE_DEVICE_TABLE(pci, vmd_ids);
>>>
>>
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

--------------qNaSdL5oAfEZidOA7wn4C39v
Content-Type: text/plain; charset=UTF-8; name="aspm-enable-take-2"
Content-Disposition: attachment; filename="aspm-enable-take-2"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIGIvZHJpdmVycy9wY2kvcGNp
ZS9hc3BtLmMKaW5kZXggMjg1NjdkNDU3NjEzLi5hNWRmNjIzMGNmM2MgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5j
CkBAIC03NjgsNiArNzY4LDMxIEBAIHN0YXRpYyB2b2lkIGFzcG1fbDFzc19pbml0KHN0cnVj
dCBwY2llX2xpbmtfc3RhdGUgKmxpbmspCiAJCWFzcG1fY2FsY19sMTJfaW5mbyhsaW5rLCBw
YXJlbnRfbDFzc19jYXAsIGNoaWxkX2wxc3NfY2FwKTsKIH0KIAorLyoKKyAqIEJJT1MgbWF5
IG5vdCBiZSBhYmxlIHRvIGFjY2VzcyBjb25maWcgc3BhY2Ugb2YgZGV2aWNlcyB1bmRlciBW
TUQgZG9tYWluLCBzbworICogaXQgcmVsaWVzIG9uIHNvZnR3YXJlIHRvIGVuYWJsZSBBU1BN
IGZvciBsaW5rcyB1bmRlciBWTUQuCisgKi8KK3N0YXRpYyBib29sIHBjaV9maXh1cF92bWRf
YnJpZGdlX2VuYWJsZV9hc3BtKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQoreworICAgICAgIHN0
cnVjdCBwY2lfYnVzICpidXMgPSBwZGV2LT5idXM7CisgICAgICAgc3RydWN0IGRldmljZSAq
ZGV2OworICAgICAgIHN0cnVjdCBwY2lfZHJpdmVyICpwZHJ2OworCisgICAgICAgaWYgKCFw
Y2lfaXNfcm9vdF9idXMoYnVzKSkKKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKKwor
ICAgICAgIGRldiA9IGJ1cy0+YnJpZGdlLT5wYXJlbnQ7CisgICAgICAgaWYgKGRldiA9PSBO
VUxMKQorICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOworCisgICAgICAgcGRydiA9IHBj
aV9kZXZfZHJpdmVyKHRvX3BjaV9kZXYoZGV2KSk7CisgICAgICAgaWYgKHBkcnYgPT0gTlVM
TCB8fCBzdHJjbXAoInZtZCIsIHBkcnYtPm5hbWUpKQorICAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOworCisgICAgICAgcGNpX2luZm8ocGRldiwgImVuYWJsZSBBU1BNIGZvciBwY2kg
YnJpZGdlIGJlaGluZCB2bWQiKTsKKyAgICAgICByZXR1cm4gdHJ1ZTsKK30KKwogc3RhdGlj
IHZvaWQgcGNpZV9hc3BtX2NhcF9pbml0KHN0cnVjdCBwY2llX2xpbmtfc3RhdGUgKmxpbmss
IGludCBibGFja2xpc3QpCiB7CiAJc3RydWN0IHBjaV9kZXYgKmNoaWxkID0gbGluay0+ZG93
bnN0cmVhbSwgKnBhcmVudCA9IGxpbmstPnBkZXY7CkBAIC04NDYsNyArODcxLDggQEAgc3Rh
dGljIHZvaWQgcGNpZV9hc3BtX2NhcF9pbml0KHN0cnVjdCBwY2llX2xpbmtfc3RhdGUgKmxp
bmssIGludCBibGFja2xpc3QpCiAJfQogCiAJLyogU2F2ZSBkZWZhdWx0IHN0YXRlICovCi0J
bGluay0+YXNwbV9kZWZhdWx0ID0gbGluay0+YXNwbV9lbmFibGVkOworCWxpbmstPmFzcG1f
ZGVmYXVsdCA9IHBjaV9maXh1cF92bWRfYnJpZGdlX2VuYWJsZV9hc3BtKHBhcmVudCkgPwor
CQlQQ0lFX0xJTktfU1RBVEVfQVNQTV9BTEwgOiBsaW5rLT5hc3BtX2VuYWJsZWQ7CiAKIAkv
KiBTZXR1cCBpbml0aWFsIGNhcGFibGUgc3RhdGUuIFdpbGwgYmUgdXBkYXRlZCBsYXRlciAq
LwogCWxpbmstPmFzcG1fY2FwYWJsZSA9IGxpbmstPmFzcG1fc3VwcG9ydDsK

--------------qNaSdL5oAfEZidOA7wn4C39v--

