Return-Path: <linux-pci+bounces-18411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF999F16BE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 20:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E93287F58
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7767118FC65;
	Fri, 13 Dec 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="bk9q/yur"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FE18E351;
	Fri, 13 Dec 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119349; cv=none; b=bSAG56F/XTw5U/l33sjmPdi32mTnHzCoFl51QneHxys7DPUYg93SYy0+7NNmItPDSnlfS6nr0pkqDebmLSiOpun0cGScGfeXWfYejqIsUWSgE2wAIjaNc7UML2P07dCrUvNv3ndhcla9LYmvLRkTAS1mo4vaRcKQ/3HdpZBOtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119349; c=relaxed/simple;
	bh=w2ucuNwRJzVECElOk49ejx/hdEkvKWZSo7duSu47xso=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=jBGAexeIKTkboOcQx3iq6PvXLX1QaqdtRfSQy0yQeK0LleauqHkmQefvQJ2t+oTm88M/t/dIyGpmoR0mnEV+C6eh1guPuN7pbXTyLK+emu8xrwf3L+jBjlsOzYXxjz2H65b8s6QUGyYdrFAZDBQ7+QmHgfOPmgpGr8+JdtIoZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=bk9q/yur; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Y90Jp3xYmz4bg0;
	Fri, 13 Dec 2024 14:48:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1734119339; bh=w2ucuNwRJzVECElOk49ejx/hdEkvKWZSo7duSu47xso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bk9q/yurzjAvqZrh6o2iM6fyqNq2mY0mpaZDnTAL+VuEQQfOcYEKeivwNNKp+bC0U
	 QArMbDy50CP9meI+hLFS2iCNtiN/q8umiMSghQwUt41tn/XLbV7NLXrCYh29BsmU8Q
	 +51oxTbklFiysrFm2F318wRAlq2aM9cfYaUF9J8k=
Content-Type: multipart/mixed; boundary="------------sATHAaKnEKv80mNFizvy4VxP"
Message-ID: <66843f3e-e8f9-40e6-8f7e-a332ff386fe7@panix.com>
Date: Fri, 13 Dec 2024 11:48:56 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
To: Bjorn Helgaas <helgaas@kernel.org>, Me <kenny@panix.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 You-Sheng Yang <vicamo.yang@canonical.com>, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>,
 Nirmal Patel <nirmal.patel@linux.ntel.com>
References: <20241213164335.GA3381091@bhelgaas>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20241213164335.GA3381091@bhelgaas>

This is a multi-part message in MIME format.
--------------sATHAaKnEKv80mNFizvy4VxP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


I was really hopeful this would have handled it, but no joy.

I also tried dropping "PCI/ASPM: Enable LTR for endpoints behind VMD" 
and "PCI/ASPM: Enable ASPM for links under VMD domain" each separately 
on top of the below quirk patch to no avail.

The only thing that works is the aggregate patch I've added.

 > However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
 > VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
 > so I'd be surprised if VMD worked for those devices unless BIOS set
 > up the VMD itself.

Yeah, my BIOS does- not sure if you'd missed it, but I'd rewritten 
"Enable LTR for endpoints behind VMD" to print if the BIOS already does 
that for you, and sent the patch here (since I wasn't seeing the message 
printed when the fixup was being done and wanted to know why).

I'd REALLY like to get this into mainline, so if there's anything I can 
do to help, LMK.

Thanks,
-Kenny


On 12/13/24 08:43, Bjorn Helgaas wrote:
> [+cc David, Nirmal, linux-pci]
> 
> On Thu, Dec 12, 2024 at 03:04:53PM -0800, Kenneth Crudup wrote:
>> On 12/12/24 12:56, Bjorn Helgaas wrote:
>>> On Wed, Dec 11, 2024 at 03:26:37PM -0800, Kenneth Crudup wrote:
>>>> So we're on 6.13-rc2 and the patches are getting closer and
>>>> closer, but they still need to be manually added.
>>>>
>>>> The good news is now only (variants of) "PCI/ASPM: Enable LTR
>>>> for endpoints behind VMD" and "PCI/ASPM: Enable ASPM for links
>>>> under VMD domain" are needed.
>> ...
> 
>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=47c7bfd31514e7b54a1f830f7707297aebbb8679
> 
> This is "UBUNTU: SAUCE: PCI/ASPM: Enable LTR for endpoints behind
> VMD", which writes PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT
> for PCI_CLASS_STORAGE_EXPRESS devices directly below VMDs with Device
> IDs 0x9a09, 0xa0b0, or 0xa0bc.
> 
> This looks equivalent in spirit to upstream
> https://git.kernel.org/linus/f492edb40b54 ("PCI: vmd: Add quirk to
> configure PCIe ASPM and LTR"), which writes PCI_LTR_MAX_SNOOP_LAT and
> PCI_LTR_MAX_NOSNOOP_LAT for any kind of device below VMDs tagged with
> VMD_FEATS_CLIENT, which includes 0x467f, 0x4c3d, 0x7d0b, 0x9a0b,
> 0xa77f, 0xad0b, 0xb06f, 0xb60b.
> 
> However, IDs 0x9a09, 0xa0b0, and 0xa0bc are NOT tagged with
> VMD_FEATS_CLIENT.  In fact, they're not included in vmd_ids[] at all,
> so I'd be surprised if VMD worked for those devices unless BIOS set
> up the VMD itself.
> 
> Maybe David or Nirmal can comment on this?
> 
>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=1a0102a08f206149d9abd56c2b28877c878b5526
> 
> This is "UBUNTU: SAUCE: PCI/ASPM: Enable ASPM for links under VMD
> domain", which adds "link->aspm_default = ASPM_STATE_ALL" for device
> IDs 0x9a09 and 0xa0b0.
> 
> This looks like it should also be handled by upstream f492edb40b54
> ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR") [1], which adds
> "pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL)".
> 
> But again, the Device IDs mentioned in the Ubuntu commit are NOT
> included in the upstream VMD_FEATS_CLIENT list.
> 
>> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/lunar/commit/?id=154d48da2c57514e4b5dadc7b8c70a4edb550981
> 
> This is "UBUNTU: SAUCE: vmd: fixup bridge ASPM by driver name
> instead", which applies the quirk that writes PCI_LTR_MAX_SNOOP_LAT
> and PCI_LTR_MAX_NOSNOOP_LAT for PCI_CLASS_STORAGE_EXPRESS devices
> below any VMD claimed by the "vmd" driver, not just VMDs with Device
> IDs 0x9a09, 0xa0b0, or 0xa0bc.
> 
> I think the only thing that's missing is that the upstream vmd_ids[]
> needs to be updated with some new VMD Device IDs that are tagged with
> VMD_FEATS_CLIENT.
> 
> I don't know what the vmd_ids[] strategy is, but Kenneth, you might
> try an upstream patch like the one below.  If that resolves the
> standby/low-power issues, maybe David or Nirmal can figure out the
> "right" way to do this.
> 
> Bjorn
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9d9596947350..4de7ff3bbf23 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -1109,6 +1109,12 @@ static const struct pci_device_id vmd_ids[] = {
>                   .driver_data = VMD_FEATS_CLIENT,},
>   	{PCI_VDEVICE(INTEL, 0xb06f),
>                   .driver_data = VMD_FEATS_CLIENT,},
> +	{PCI_VDEVICE(INTEL, 0x9a09),
> +                .driver_data = VMD_FEATS_CLIENT,},
> +	{PCI_VDEVICE(INTEL, 0xa0b0),
> +                .driver_data = VMD_FEATS_CLIENT,},
> +	{PCI_VDEVICE(INTEL, 0xa0bc),
> +                .driver_data = VMD_FEATS_CLIENT,},
>   	{0,}
>   };
>   MODULE_DEVICE_TABLE(pci, vmd_ids);
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

--------------sATHAaKnEKv80mNFizvy4VxP
Content-Type: text/plain; charset=UTF-8; name="aspm-vmd-patch"
Content-Disposition: attachment; filename="aspm-vmd-patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIGIvZHJpdmVycy9wY2kvcGNp
ZS9hc3BtLmMKaW5kZXggMjg1NjdkNDU3NjEzLi42Y2VjOGVkMWE3MjYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jCisrKyBiL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5j
CkBAIC04NDYsNyArODQ2LDggQEAgc3RhdGljIHZvaWQgcGNpZV9hc3BtX2NhcF9pbml0KHN0
cnVjdCBwY2llX2xpbmtfc3RhdGUgKmxpbmssIGludCBibGFja2xpc3QpCiAJfQogCiAJLyog
U2F2ZSBkZWZhdWx0IHN0YXRlICovCi0JbGluay0+YXNwbV9kZWZhdWx0ID0gbGluay0+YXNw
bV9lbmFibGVkOworCWxpbmstPmFzcG1fZGVmYXVsdCA9IHBhcmVudC0+ZGV2X2ZsYWdzICYg
UENJX0RFVl9GTEFHU19FTkFCTEVfQVNQTSA/CisJCQkgICAgIFBDSUVfTElOS19TVEFURV9B
U1BNX0FMTCA6IGxpbmstPmFzcG1fZW5hYmxlZDsKIAogCS8qIFNldHVwIGluaXRpYWwgY2Fw
YWJsZSBzdGF0ZS4gV2lsbCBiZSB1cGRhdGVkIGxhdGVyICovCiAJbGluay0+YXNwbV9jYXBh
YmxlID0gbGluay0+YXNwbV9zdXBwb3J0OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcXVp
cmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwppbmRleCA3NmY0ZGY3NWIwOGEuLmM1MTQ1
ZTc0ZGY3MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMKKysrIGIvZHJpdmVy
cy9wY2kvcXVpcmtzLmMKQEAgLTYzMDEsMyArNjMwMSw3MCBAQCBzdGF0aWMgdm9pZCBwY2lf
bWFza19yZXBsYXlfdGltZXJfdGltZW91dChzdHJ1Y3QgcGNpX2RldiAqcGRldikKIERFQ0xB
UkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfR0xJLCAweDk3NTAsIHBjaV9tYXNr
X3JlcGxheV90aW1lcl90aW1lb3V0KTsKIERFQ0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9W
RU5ET1JfSURfR0xJLCAweDk3NTUsIHBjaV9tYXNrX3JlcGxheV90aW1lcl90aW1lb3V0KTsK
ICNlbmRpZgorLyoKKyAqIEJJT1MgbWF5IG5vdCBiZSBhYmxlIHRvIGFjY2VzcyBjb25maWcg
c3BhY2Ugb2YgZGV2aWNlcyB1bmRlciBWTUQgZG9tYWluLCBzbworICogaXQgcmVsaWVzIG9u
IHNvZnR3YXJlIHRvIGVuYWJsZSBBU1BNIGZvciBsaW5rcyB1bmRlciBWTUQuCisgKi8KK3N0
YXRpYyBib29sIHBjaV9maXh1cF9pc192bWRfYnJpZGdlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
KQoreworCXN0cnVjdCBwY2lfYnVzICpidXMgPSBwZGV2LT5idXM7CisJc3RydWN0IGRldmlj
ZSAqZGV2OworCXN0cnVjdCBwY2lfZHJpdmVyICpwZHJ2OworCisJaWYgKCFwY2lfaXNfcm9v
dF9idXMoYnVzKSkKKwkJcmV0dXJuIGZhbHNlOworCisJZGV2ID0gYnVzLT5icmlkZ2UtPnBh
cmVudDsKKwlpZiAoZGV2ID09IE5VTEwpCisJCXJldHVybiBmYWxzZTsKKworCXBkcnYgPSBw
Y2lfZGV2X2RyaXZlcih0b19wY2lfZGV2KGRldikpOworCWlmIChwZHJ2ID09IE5VTEwgfHwg
c3RyY21wKCJ2bWQiLCBwZHJ2LT5uYW1lKSkKKwkJcmV0dXJuIGZhbHNlOworCisJcmV0dXJu
IHRydWU7Cit9CisKK3N0YXRpYyB2b2lkIHBjaV9maXh1cF9lbmFibGVfYXNwbShzdHJ1Y3Qg
cGNpX2RldiAqcGRldikKK3sKKwlpZiAoIXBjaV9maXh1cF9pc192bWRfYnJpZGdlKHBkZXYp
KQorCQlyZXR1cm47CisKKwlwZGV2LT5kZXZfZmxhZ3MgfD0gUENJX0RFVl9GTEFHU19FTkFC
TEVfQVNQTTsKKwlwY2lfaW5mbyhwZGV2LCAiZW5hYmxlIEFTUE0gZm9yIHBjaSBicmlkZ2Ug
YmVoaW5kIHZtZCIpOworfQorREVDTEFSRV9QQ0lfRklYVVBfQ0xBU1NfSEVBREVSKFBDSV9W
RU5ET1JfSURfSU5URUwsIFBDSV9BTllfSUQsCisJCQkgICAgICAgUENJX0NMQVNTX0JSSURH
RV9QQ0ksIDgsIHBjaV9maXh1cF9lbmFibGVfYXNwbSk7CisKK3N0YXRpYyB2b2lkIHBjaV9m
aXh1cF9lbmFibGVfdm1kX252bWVfbHRyKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQoreworCXN0
cnVjdCBwY2lfZGV2ICpwYXJlbnQ7CisJaW50IHBvczsKKwl1MTYgdmFsOworCisJcGFyZW50
ID0gcGNpX3Vwc3RyZWFtX2JyaWRnZShwZGV2KTsKKwlpZiAoIXBhcmVudCkKKwkJcmV0dXJu
OworCisJaWYgKCFwY2lfZml4dXBfaXNfdm1kX2JyaWRnZShwYXJlbnQpKQorCQlyZXR1cm47
CisKKwlwb3MgPSBwY2lfZmluZF9leHRfY2FwYWJpbGl0eShwZGV2LCBQQ0lfRVhUX0NBUF9J
RF9MVFIpOworCWlmICghcG9zKQorCQlyZXR1cm47CisKKwlwY2lfcmVhZF9jb25maWdfd29y
ZChwZGV2LCBwb3MgKyBQQ0lfTFRSX01BWF9TTk9PUF9MQVQsICZ2YWwpOworCWlmICh2YWwp
CisJCXJldHVybjsKKworCXBjaV9yZWFkX2NvbmZpZ193b3JkKHBkZXYsIHBvcyArIFBDSV9M
VFJfTUFYX05PU05PT1BfTEFULCAmdmFsKTsKKwlpZiAodmFsKQorCQlyZXR1cm47CisKKwkv
KiAzMTQ1NzI4bnMsIGkuZS4gMHgzMDAwMDBucyAqLworCXBjaV93cml0ZV9jb25maWdfd29y
ZChwZGV2LCBwb3MgKyBQQ0lfTFRSX01BWF9TTk9PUF9MQVQsIDB4MTAwMyk7CisJcGNpX3dy
aXRlX2NvbmZpZ193b3JkKHBkZXYsIHBvcyArIFBDSV9MVFJfTUFYX05PU05PT1BfTEFULCAw
eDEwMDMpOworCXBjaV9pbmZvKHBkZXYsICJlbmFibGUgTFRSIGZvciBudm1lIGJlaGluZCB2
bWQiKTsKK30KK0RFQ0xBUkVfUENJX0ZJWFVQX0NMQVNTX0VBUkxZKFBDSV9BTllfSUQsIFBD
SV9BTllfSUQsCisJCQkgICAgICBQQ0lfQ0xBU1NfU1RPUkFHRV9FWFBSRVNTLCAwLCBwY2lf
Zml4dXBfZW5hYmxlX3ZtZF9udm1lX2x0cik7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3BjaS5oIGIvaW5jbHVkZS9saW51eC9wY2kuaAppbmRleCBkYjliNDdjZTNlZWYuLjliZDgy
MzRmMWQzOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9wY2kuaAorKysgYi9pbmNsdWRl
L2xpbnV4L3BjaS5oCkBAIC0yNDUsNiArMjQ1LDggQEAgZW51bSBwY2lfZGV2X2ZsYWdzIHsK
IAlQQ0lfREVWX0ZMQUdTX05PX1JFTEFYRURfT1JERVJJTkcgPSAoX19mb3JjZSBwY2lfZGV2
X2ZsYWdzX3QpICgxIDw8IDExKSwKIAkvKiBEZXZpY2UgZG9lcyBob25vciBNU0kgbWFza2lu
ZyBkZXNwaXRlIHNheWluZyBvdGhlcndpc2UgKi8KIAlQQ0lfREVWX0ZMQUdTX0hBU19NU0lf
TUFTS0lORyA9IChfX2ZvcmNlIHBjaV9kZXZfZmxhZ3NfdCkgKDEgPDwgMTIpLAorCS8qIEVu
YWJsZSBBU1BNIHJlZ2FyZGxlc3Mgb2YgaG93IExua0N0bCBpcyBwcm9ncmFtbWVkICovCisJ
UENJX0RFVl9GTEFHU19FTkFCTEVfQVNQTSA9IChfX2ZvcmNlIHBjaV9kZXZfZmxhZ3NfdCkg
KDEgPDwgMTMpLAogfTsKIAogZW51bSBwY2lfaXJxX3Jlcm91dGVfdmFyaWFudCB7Cg==

--------------sATHAaKnEKv80mNFizvy4VxP--

