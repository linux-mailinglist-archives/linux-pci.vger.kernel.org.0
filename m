Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF26BA3D7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 01:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCOABA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 20:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCOAA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 20:00:58 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80825BB0
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678838456; x=1710374456;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to;
  bh=X1YHXuUVchLV9noeB2/flcYh3ZszOSKCrWX1/iB730Y=;
  b=O2kS/LGlMTSthmkmW70xyXkOhW71pgOiEHxrzFouiMNAe6nixVywmI/N
   ux3yIRM4+y/lJS8ZBCs6ByM/wNbWmo/iANm3fs0lHmhBEpX+x474GW4Te
   y8bpb3QanqKHQT5LSIBc21XZoG472PpucRRQenTH1pvowUFwHWjBa0Nnx
   VXAOTQLH4Tijds6nuC4SW1cByt97SK7dkIarOomnuvSUkqLaGJoQyjoDK
   EhurKGOi2xAVvioHANbRAd1F1cPQOtfc1dnrDSIwuDkMde1MwTV66n+9K
   lLBqghNeytWqjAbAMMwMaB13djit9Ih2aePUtiqPfPkgulOM+eU5lQ2vg
   g==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208,223";a="337665973"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 08:00:50 +0800
IronPort-SDR: yRNXhaNt7GZaFq0mLm8951EjG9AvTYDAUdsNDSBM32RdWJmxneltdJQGY8uM/qoTbi1pT/TaOa
 NVazV+1+Uvf0eKcaDkrZF/11QTsqJXcT8mSsGhc955KArK8CZW2dEH8lOU+aDQElQt5uXPWc9f
 dtscbSI/ZvdZ/21eqMjEhRgCuhuhzye0HhbfDcirRZ88sgzl+ukPfQYmC2qCoB7wKCAnLfyxWM
 USieQIh8VUWTOQTXtqEPckch9GS5HRcqUpbbLTfmLPq1nh2VXyMeEbXdOxvRzXGyxzi0DdLLkO
 Bfo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 16:11:36 -0700
IronPort-SDR: 2KGnELgPgMmTZAaTpZ7KEZwlw6hwTsgbA+OPjqnAZJ5RbRw3AUhpeLFFrOCY0NCaog+B1SkvMx
 p78jGWl7w0pRRxtxh626u27Sc3n4nkU3ZJMagf9VjeDxIXXrVJ061P3MZWuYz5siTaoBw3X/B9
 KXxkU18kaubQo+aMXX1vjGOSOBC54LWo+kTse2KSvSoMpOlkqMBdB3kHj/x/BMPM9whZDqnJuv
 XjPHLXudOX1TNM7gL/jjU575wNLqTzAF1bvzjCevBR9q2t9cxojtc2iwBzNqjL6ol4m4cvOaoU
 mUs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:00:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbrBn2lqLz1RtVq
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 17:00:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=in-reply-to:organization:references:to
        :from:content-language:subject:user-agent:mime-version:date
        :message-id:content-type; s=dkim; t=1678838446; x=1681430447;
         bh=X1YHXuUVchLV9noeB2/flcYh3ZszOSKCrWX1/iB730Y=; b=ceXoSFFl3w/N
        ST9J5aiNtVKs5EpeqFObkuyNkOuiWPpYSbSB6HMxDsh9YUsiNka7626GqRGg87x3
        AkKz/AwqS0kW/lIXZnM1DkoyxbqcxXTcILJd9fU3QGOCuBgeMM8txHbxHROgWVNV
        2dwVkaKDrQWNKTSLHoLIwcChrD0p+cbTg9NBsT/Fj7BLsIb4w53oWQYgVOdOmmZv
        OQfig7pY2SiXtyT3WoGMcSSuGWwfk5THcmwFLkJbQbxqPXeXYPL/CU2/sXMLKo56
        jyBEdOpaN3e1GrFmP1ItXGEVt9oWBM302XiP2aGgS4mVnRxeQ6rjrwev3tThlEYa
        lwBFRbkJhA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7njlg-D6OZ52 for <linux-pci@vger.kernel.org>;
        Tue, 14 Mar 2023 17:00:46 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbrBf1mWkz1RtVm;
        Tue, 14 Mar 2023 17:00:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------esXA1Txh2YMjp00vl8W3xCHC"
Message-ID: <1e8184e9-7e0b-2598-cc5a-e46d6c2f152a@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 09:00:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller
 driver
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com>
 <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
 <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com>
 <CAAEEuhqk0scWd3wFbVb9fSgHxPBKotpEPNi+YPG4GD9vLO94mw@mail.gmail.com>
 <8392a7de-666a-bce6-dc9f-b60d6dd93013@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8392a7de-666a-bce6-dc9f-b60d6dd93013@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------esXA1Txh2YMjp00vl8W3xCHC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/23 07:54, Damien Le Moal wrote:
> On 3/14/23 23:53, Rick Wertenbroek wrote:
>> Hello Damien,
>> I also noticed random issues I suspect to be related to link status or power
>> state, in my case it sometimes happens that the BARs (0-6) in the config
>> space get reset to 0. This is not due to the driver because the driver never
>> ever accesses these registers (@0xfd80'0010 to 0xfd80'0024 TRM
>> 17.6.4.1.5-17.6.4.1.10).
>> I don't think the host rewrites them because lspci shows the BARs as
>> "[virtual]" which means they have been assigned by host but have 0
>> value in the endpoint device (when lspci rereads the PCI config header).
>> See https://github.com/pciutils/pciutils/blob/master/lspci.c#L422
>>
>> So I suspect the controller detects something related to link status or
>> power state and internally (in hardware) resets those registers. It's not
>> the kernel code, it never accesses these regs. The problem occurs
>> very randomly, sometimes in a few seconds, sometimes I cannot see
>> it for a whole day.
>>
>> Is this similar to what you are experiencing ?
> 
> Yes. I sometimes get NMIs after starting the function driver, when my function
> driver starts probing the bar registers after seeing the host changing one
> register. And the link also comes up with 4 lanes or 2 lanes, random.
> 
>> Do you have any idea as to what could make these registers to be reset
>> (I could not find anything in the TRM, also nothing in the driver seems to
>> cause it).
> 
> My thinking is that since we do not have a linkup notifier, the function driver
> starts setting things up without the link established (e.g. when the host is
> still powered down). Once the host start booting and pic link is established,
> things may be reset in the hardware... That is the only thing I can think of.
> 
> And yes, there are definitely something going on with the power states too I
> think: if I let things idle for a few minutes, everything stops working: no
> activity seen on the endpoint over the BARs. I tried enabling the sys and client
> interrupts to see if I can see power state changes, or if clearing the
> interrupts helps (they are masked by default), but no change. And booting the
> host with pci_aspm=off does not help either. Also tried to change all the
> capabilities related to link & power states to "off" (not supported), and no
> change either. So currently, I am out of ideas regarding that one.
> 
> I am trying to make progress on my endpoint driver (nvme function) to be sure it
> is not a bug there that breaks things. I may still have something bad because
> when I enable the BIOS native NVMe driver on the host, either the host does not
> boot, or grub crashes with memory corruptions. Overall, not yet very stable and
> still trying to sort out the root cause of that.

By the way, enabling the interrupts to see the error notifications, I do see a
lot of retry timeout and other recoverable errors. So the issues I am seeing
could be due to my PCI cable setup that is not ideal (bad signal, ground loops,
... ?). Not sure. I do not have a PCI analyzer handy :)

I attached the patches I used to enable the EP interrupts. Enabling debug prints
will tell you what is going on. That may give you some hints on your setup ?

-- 
Damien Le Moal
Western Digital Research

--------------esXA1Txh2YMjp00vl8W3xCHC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-arm-rk3399-rockpro64-Add-interrupts-to-PCI-endpoint-.patch"
Content-Disposition: attachment;
 filename*0="0001-arm-rk3399-rockpro64-Add-interrupts-to-PCI-endpoint-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmZGU2NjdlODg5NTQ4YTA2NDAwOWM0NWVhNDg5MWI3ODk3Nzk2MmI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBv
cGVuc291cmNlLndkYy5jb20+CkRhdGU6IFR1ZSwgMjggRmViIDIwMjMgMTc6MDA6MzIgKzA5
MDAKU3ViamVjdDogW1BBVENIXSBhcm06IHJrMzM5OS1yb2NrcHJvNjQ6IEFkZCBpbnRlcnJ1
cHRzIHRvIFBDSSBlbmRwb2ludCBtb2RlIERUCiBub2RlCgpBZGQgc3Vic3lzdGVtIGFuZCBj
bGllbnQgaW50ZXJydXB0cyBkZWZpbml0aW9ucyB0byB0aGUgcm9ja2NoaXAgUENJCmVlbmRw
b2ludCBub2RlLgoKU2lnbmVkLW9mZi1ieTogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1v
YWxAb3BlbnNvdXJjZS53ZGMuY29tPgotLS0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2No
aXAvcmszMzk5LmR0c2kgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszMzk5LmR0
c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzM5OS5kdHNpCmluZGV4IGMz
NDg5YmUzODUyZC4uOTJlYjU0MWZkZTlkIDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL3JvY2tjaGlwL3JrMzM5OS5kdHNpCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcm9j
a2NoaXAvcmszMzk5LmR0c2kKQEAgLTI3NCw2ICsyNzQsOSBAQCBwY2llMF9lcDogcGNpZS1l
cEBmODAwMDAwMCB7CiAJCQk8JmNydSBQQ0xLX1BDSUU+LCA8JmNydSBTQ0xLX1BDSUVfUE0+
OwogCQljbG9jay1uYW1lcyA9ICJhY2xrIiwgImFjbGstcGVyZiIsCiAJCQkJImhjbGsiLCAi
cG0iOworCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNDkgSVJRX1RZUEVfTEVWRUxfSElHSCAw
PiwKKwkJCSAgICAgPEdJQ19TUEkgNTEgSVJRX1RZUEVfTEVWRUxfSElHSCAwPjsKKwkJaW50
ZXJydXB0LW5hbWVzID0gInN5cyIsICJjbGllbnQiOwogCQltYXgtZnVuY3Rpb25zID0gL2Jp
dHMvIDggPDg+OwogCQludW0tbGFuZXMgPSA8ND47CiAJCXJlZyA9IDwweDAgMHhmZDAwMDAw
MCAweDAgMHgxMDAwMDAwPiwgPDB4MCAweGZhMDAwMDAwIDB4MCAweDIwMDAwMDA+OwotLSAK
Mi4zOS4yCgo=
--------------esXA1Txh2YMjp00vl8W3xCHC
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-PCI-rockchip-Add-client-and-subsys-interrupts-for-en.patch"
Content-Disposition: attachment;
 filename*0="0001-PCI-rockchip-Add-client-and-subsys-interrupts-for-en.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5ZjIzNmI5YWMwMmU1MjQwN2VhOWQ4ODkyMGFkYTI4ODdjZWM4NzJjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBv
cGVuc291cmNlLndkYy5jb20+CkRhdGU6IFR1ZSwgMjggRmViIDIwMjMgMTY6NTc6MDEgKzA5
MDAKU3ViamVjdDogW1BBVENIXSBQQ0k6IHJvY2tjaGlwOiBBZGQgY2xpZW50IGFuZCBzdWJz
eXMgaW50ZXJydXB0cyBmb3IgZW5kcG9pbnQKIG1vZGUKCkFkZCBhbiBpbnRlcnJ1cHQgaGFu
ZGxlciBmb3IgdGhlIGNsaWVudCBhbmQgc3Vic3lzdGVtIGludGVycnVwdHMgdG8KdGhlIHJv
Y2tjaGlwIGVuZHBvaW50IGRyaXZlci4gQ2xlYXJpbmcgdGhlc2UgaW50ZXJydXB0cyBpcyBu
ZWNlc3NzYXJ5CnRvIGF2b2lkIHNlZWluZyB0aGUgY29udHJvbGxlciBnZXR0aW5nIHN0dWNr
IG9uIG5vbiBmYXRhbCBlcnJvcnMuCgpTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8
ZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+Ci0tLQogZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLXJvY2tjaGlwLWVwLmMgfCAxNzYgKysrKysrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDE3NiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlwLWVwLmMgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUtcm9ja2NoaXAtZXAuYwppbmRleCAxMmRiOWE5ZDkyYWYuLmMxZDM5
ZDNiNDVkYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tj
aGlwLWVwLmMKKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXJvY2tjaGlwLWVw
LmMKQEAgLTUwLDYgKzUwLDE3NiBAQCBzdHJ1Y3Qgcm9ja2NoaXBfcGNpZV9lcCB7CiAJdTgJ
CQlpcnFfcGVuZGluZzsKIH07CiAKK3N0YXRpYyB2b2lkIHJvY2tjaGlwX3BjaWVfZXBfaGFu
ZGxlX2xvY2FsX2ludChzdHJ1Y3Qgcm9ja2NoaXBfcGNpZSAqcm9ja2NoaXApCit7CisJc3Ry
dWN0IGRldmljZSAqZGV2ID0gcm9ja2NoaXAtPmRldjsKKwl1MzIgcmVnOworCisJZGV2X2Ri
ZyhkZXYsICJsb2NhbCBpbnRlcnJ1cHQgcmVjZWl2ZWRcbiIpOworCisJcmVnID0gcm9ja2No
aXBfcGNpZV9yZWFkKHJvY2tjaGlwLCBQQ0lFX0NPUkVfSU5UX1NUQVRVUyk7CisJaWYgKHJl
ZyAmIFBDSUVfQ09SRV9JTlRfUFJGUEUpCisJCWRldl9kYmcoZGV2LCAicGFyaXR5IGVycm9y
IGRldGVjdGVkIHdoaWxlIHJlYWRpbmcgZnJvbSB0aGUgUE5QIHJlY2VpdmUgRklGTyBSQU1c
biIpOworCisJaWYgKHJlZyAmIFBDSUVfQ09SRV9JTlRfQ1JGUEUpCisJCWRldl9kYmcoZGV2
LCAicGFyaXR5IGVycm9yIGRldGVjdGVkIHdoaWxlIHJlYWRpbmcgZnJvbSB0aGUgQ29tcGxl
dGlvbiBSZWNlaXZlIEZJRk8gUkFNXG4iKTsKKworCWlmIChyZWcgJiBQQ0lFX0NPUkVfSU5U
X1JSUEUpCisJCWRldl9kYmcoZGV2LCAicGFyaXR5IGVycm9yIGRldGVjdGVkIHdoaWxlIHJl
YWRpbmcgZnJvbSByZXBsYXkgYnVmZmVyIFJBTVxuIik7CisKKwlpZiAocmVnICYgUENJRV9D
T1JFX0lOVF9QUkZPKQorCQlkZXZfZGJnKGRldiwgIm92ZXJmbG93IG9jY3VycmVkIGluIHRo
ZSBQTlAgcmVjZWl2ZSBGSUZPXG4iKTsKKworCWlmIChyZWcgJiBQQ0lFX0NPUkVfSU5UX0NS
Rk8pCisJCWRldl9kYmcoZGV2LCAib3ZlcmZsb3cgb2NjdXJyZWQgaW4gdGhlIGNvbXBsZXRp
b24gcmVjZWl2ZSBGSUZPXG4iKTsKKworCWlmIChyZWcgJiBQQ0lFX0NPUkVfSU5UX1JUKQor
CQlkZXZfZGJnKGRldiwgInJlcGxheSB0aW1lciB0aW1lZCBvdXRcbiIpOworCisJaWYgKHJl
ZyAmIFBDSUVfQ09SRV9JTlRfUlRSKQorCQlkZXZfZGJnKGRldiwgInJlcGxheSB0aW1lciBy
b2xsZWQgb3ZlciBhZnRlciA0IHRyYW5zbWlzc2lvbnMgb2YgdGhlIHNhbWUgVExQXG4iKTsK
KworCWlmIChyZWcgJiBQQ0lFX0NPUkVfSU5UX1BFKQorCQlkZXZfZGJnKGRldiwgInBoeSBl
cnJvciBkZXRlY3RlZCBvbiByZWNlaXZlIHNpZGVcbiIpOworCisJaWYgKHJlZyAmIFBDSUVf
Q09SRV9JTlRfTVRSKQorCQlkZXZfZGJnKGRldiwgIm1hbGZvcm1lZCBUTFAgcmVjZWl2ZWQg
ZnJvbSB0aGUgbGlua1xuIik7CisKKwlpZiAocmVnICYgUENJRV9DT1JFX0lOVF9VQ1IpCisJ
CWRldl9kYmcoZGV2LCAibWFsZm9ybWVkIFRMUCByZWNlaXZlZCBmcm9tIHRoZSBsaW5rXG4i
KTsKKworCWlmIChyZWcgJiBQQ0lFX0NPUkVfSU5UX0ZDRSkKKwkJZGV2X2RiZyhkZXYsICJh
biBlcnJvciB3YXMgb2JzZXJ2ZWQgaW4gdGhlIGZsb3cgY29udHJvbCBhZHZlcnRpc2VtZW50
cyBmcm9tIHRoZSBvdGhlciBzaWRlXG4iKTsKKworCWlmIChyZWcgJiBQQ0lFX0NPUkVfSU5U
X0NUKQorCQlkZXZfZGJnKGRldiwgImEgcmVxdWVzdCB0aW1lZCBvdXQgd2FpdGluZyBmb3Ig
Y29tcGxldGlvblxuIik7CisKKwlpZiAocmVnICYgUENJRV9DT1JFX0lOVF9VVEMpCisJCWRl
dl9kYmcoZGV2LCAidW5tYXBwZWQgVEMgZXJyb3JcbiIpOworCisJaWYgKHJlZyAmIFBDSUVf
Q09SRV9JTlRfTU1WQykKKwkJZGV2X2RiZyhkZXYsICJNU0kgbWFzayByZWdpc3RlciBjaGFu
Z2VzXG4iKTsKKworCXJvY2tjaGlwX3BjaWVfd3JpdGUocm9ja2NoaXAsIHJlZywgUENJRV9D
T1JFX0lOVF9TVEFUVVMpOworfQorCitzdGF0aWMgaXJxcmV0dXJuX3Qgcm9ja2NoaXBfcGNp
ZV9lcF9pcnFfaGFuZGxlcihpbnQgaXJxLCB2b2lkICphcmcpCit7CisJc3RydWN0IHJvY2tj
aGlwX3BjaWUgKnJvY2tjaGlwID0gYXJnOworCXN0cnVjdCBkZXZpY2UgKmRldiA9IHJvY2tj
aGlwLT5kZXY7CisJdTMyIHJlZywgbWFzayA9IDA7CisKKwlyZWcgPSByb2NrY2hpcF9wY2ll
X3JlYWQocm9ja2NoaXAsIFBDSUVfQ0xJRU5UX0lOVF9TVEFUVVMpOworCisJaWYgKHJlZyAm
IFBDSUVfQ0xJRU5UX0lOVF9MRUdBQ1lfRE9ORSkgeworCQlkZXZfZGJnKGRldiwgImxlZ2Fj
eSBkb25lIGludGVycnVwdCByZWNlaXZlZFxuIik7CisJCW1hc2sgfD0gUENJRV9DTElFTlRf
SU5UX0xFR0FDWV9ET05FOworCX0KKworCWlmIChyZWcgJiBQQ0lFX0NMSUVOVF9JTlRfTVNH
KSB7CisJCWRldl9kYmcoZGV2LCAibWVzc2FnZSBkb25lIGludGVycnVwdCByZWNlaXZlZFxu
Iik7CisJCW1hc2sgfD0gUENJRV9DTElFTlRfSU5UX01TRzsKKwl9CisKKwlpZiAocmVnICYg
UENJRV9DTElFTlRfSU5UX0hPVF9SU1QpIHsKKwkJZGV2X2RiZyhkZXYsICJob3QgcmVzZXQg
aW50ZXJydXB0IHJlY2VpdmVkXG4iKTsKKwkJbWFzayB8PSBQQ0lFX0NMSUVOVF9JTlRfSE9U
X1JTVDsKKwl9CisKKwlpZiAocmVnICYgUENJRV9DTElFTlRfSU5UX0RQQSkgeworCQlkZXZf
ZGJnKGRldiwgImRwYSBpbnRlcnJ1cHQgcmVjZWl2ZWRcbiIpOworCQltYXNrIHw9IFBDSUVf
Q0xJRU5UX0lOVF9EUEE7CisJfQorCisJaWYgKHJlZyAmIFBDSUVfQ0xJRU5UX0lOVF9GQVRB
TF9FUlIpIHsKKwkJZGV2X2RiZyhkZXYsICJmYXRhbCBlcnJvciBpbnRlcnJ1cHQgcmVjZWl2
ZWRcbiIpOworCQltYXNrIHw9IFBDSUVfQ0xJRU5UX0lOVF9GQVRBTF9FUlI7CisJfQorCisJ
aWYgKHJlZyAmIFBDSUVfQ0xJRU5UX0lOVF9ORkFUQUxfRVJSKSB7CisJCWRldl9kYmcoZGV2
LCAibm8gZmF0YWwgZXJyb3IgaW50ZXJydXB0IHJlY2VpdmVkXG4iKTsKKwkJbWFzayB8PSBQ
Q0lFX0NMSUVOVF9JTlRfTkZBVEFMX0VSUjsKKwl9CisKKwlpZiAocmVnICYgUENJRV9DTElF
TlRfSU5UX0NPUlJfRVJSKSB7CisJCWRldl9kYmcoZGV2LCAiY29ycmVjdGFibGUgZXJyb3Ig
aW50ZXJydXB0IHJlY2VpdmVkXG4iKTsKKwkJbWFzayB8PSBQQ0lFX0NMSUVOVF9JTlRfQ09S
Ul9FUlI7CisJfQorCisJaWYgKHJlZyAmIFBDSUVfQ0xJRU5UX0lOVF9MT0NBTCkgeworCQly
b2NrY2hpcF9wY2llX2VwX2hhbmRsZV9sb2NhbF9pbnQocm9ja2NoaXApOworCQltYXNrIHw9
IFBDSUVfQ0xJRU5UX0lOVF9MT0NBTDsKKwl9CisKKwlpZiAocmVnICYgUENJRV9DTElFTlRf
SU5UX1VETUEpIHsKKwkJZGV2X2RiZyhkZXYsICJ1RE1BIGludGVycnVwdCByZWNlaXZlZFxu
Iik7CisJCW1hc2sgfD0gUENJRV9DTElFTlRfSU5UX1VETUE7CisJfQorCisJaWYgKHJlZyAm
IFBDSUVfQ0xJRU5UX0lOVF9QSFkpIHsKKwkJZGV2X2RiZyhkZXYsICJwaHkgaW50ZXJydXB0
IHJlY2VpdmVkXG4iKTsKKwkJbWFzayB8PSBQQ0lFX0NMSUVOVF9JTlRfUEhZOworCX0KKwor
CWlmIChyZWcgJiBQQ0lFX0NMSUVOVF9JTlRfUFdSX1NUQ0cpIHsKKwkJZGV2X2RiZyhkZXYs
ICJQb3dlciBzdGF0ZSBjaGFuZ2UgaW50ZXJydXB0IHJlY2VpdmVkXG4iKTsKKwkJbWFzayB8
PSBQQ0lFX0NMSUVOVF9JTlRfUFdSX1NUQ0c7CisJfQorCisJcm9ja2NoaXBfcGNpZV93cml0
ZShyb2NrY2hpcCwgcmVnICYgbWFzaywgUENJRV9DTElFTlRfSU5UX1NUQVRVUyk7CisKKwly
ZXR1cm4gSVJRX0hBTkRMRUQ7Cit9CisKK3N0YXRpYyBpbnQgcm9ja2NoaXBfcGNpZV9lcF9z
ZXR1cF9pcnEoc3RydWN0IHJvY2tjaGlwX3BjaWUgKnJvY2tjaGlwKQoreworCWludCBpcnEs
IGVycjsKKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSByb2NrY2hpcC0+ZGV2OworCXN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KTsKKworCWly
cSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKHBkZXYsICJzeXMiKTsKKwlpZiAoaXJxIDwg
MCkKKwkJcmV0dXJuIGlycTsKKworCS8qIFBDSWUgc3Vic3lzdGVtIGludGVycnVwdCAqLwor
CWVyciA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBpcnEsIHJvY2tjaGlwX3BjaWVfZXBfaXJx
X2hhbmRsZXIsCisJCQkgICAgICAgSVJRRl9TSEFSRUQsICJwY2llLWVwLXN5cyIsIHJvY2tj
aGlwKTsKKwlpZiAoZXJyKSB7CisJCWRldl9lcnIoZGV2LCAiUmVxdWVzdCBQQ0llIHN1YnN5
c3RlbSBJUlEgZmFpbGVkXG4iKTsKKwkJcmV0dXJuIGVycjsKKwl9CisKKwkvKiBQQ0llIGNs
aWVudCBpbnRlcnJ1cHQgKi8KKwlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZShwZGV2
LCAiY2xpZW50Iik7CisJaWYgKGlycSA8IDApCisJCXJldHVybiBpcnE7CisKKwllcnIgPSBk
ZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJxLCByb2NrY2hpcF9wY2llX2VwX2lycV9oYW5kbGVy
LAorCQkJICAgICAgIElSUUZfU0hBUkVELCAicGNpZS1lcC1jbGllbnQiLCByb2NrY2hpcCk7
CisJaWYgKGVycikgeworCQlkZXZfZXJyKGRldiwgIlJlcXVlc3QgUENJZSBjbGllbnQgSVJR
IGZhaWxlZFxuIik7CisJCXJldHVybiBlcnI7CisJfQorCisJcmV0dXJuIDA7Cit9CisKK3N0
YXRpYyB2b2lkIHJvY2tjaGlwX3BjaWVfZXBfZW5hYmxlX2ludGVycnVwdHMoc3RydWN0IHJv
Y2tjaGlwX3BjaWUgKnJvY2tjaGlwKQoreworCXUzMiBjbGllbnRfbWFzayA9IFBDSUVfQ0xJ
RU5UX0lOVF9MRUdBQ1lfRE9ORSB8CisJCVBDSUVfQ0xJRU5UX0lOVF9NU0cgfCBQQ0lFX0NM
SUVOVF9JTlRfRFBBIHwKKwkJUENJRV9DTElFTlRfSU5UX0ZBVEFMX0VSUiB8IFBDSUVfQ0xJ
RU5UX0lOVF9ORkFUQUxfRVJSIHwKKwkJUENJRV9DTElFTlRfSU5UX0NPUlJfRVJSIHwKKwkJ
UENJRV9DTElFTlRfSU5UX0xPQ0FMIHwgUENJRV9DTElFTlRfSU5UX1VETUEgfAorCQlQQ0lF
X0NMSUVOVF9JTlRfUFdSX1NUQ0c7CisKKwlyb2NrY2hpcF9wY2llX3dyaXRlKHJvY2tjaGlw
LCAoY2xpZW50X21hc2sgPDwgMTYpICYgfmNsaWVudF9tYXNrLAorCQkJICAgIFBDSUVfQ0xJ
RU5UX0lOVF9NQVNLKTsKKworCXJvY2tjaGlwX3BjaWVfd3JpdGUocm9ja2NoaXAsICh1MzIp
KH5QQ0lFX0NPUkVfSU5UKSwKKwkJCSAgICBQQ0lFX0NPUkVfSU5UX01BU0spOworfQorCiBz
dGF0aWMgaW5saW5lIGludCByb2NrY2hpcF9vYl9yZWdpb24odTY0IHBoeXNfYWRkcikKIHsK
IAlyZXR1cm4gKHBoeXNfYWRkciA+PiBpbG9nMihTWl8xTSkpICYgMHgxZjsKQEAgLTYzNyw2
ICs4MDcsMTIgQEAgc3RhdGljIGludCByb2NrY2hpcF9wY2llX2VwX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAKIAlyb2NrY2hpcF9wY2llX3dyaXRlKHJvY2tjaGlw
LCBQQ0lFX0NMSUVOVF9DT05GX0VOQUJMRSwgUENJRV9DTElFTlRfQ09ORklHKTsKIAorCWVy
ciA9IHJvY2tjaGlwX3BjaWVfZXBfc2V0dXBfaXJxKHJvY2tjaGlwKTsKKwlpZiAoZXJyKQor
CQlnb3RvIGVycl9lcGNfbWVtX2V4aXQ7CisKKwlyb2NrY2hpcF9wY2llX2VwX2VuYWJsZV9p
bnRlcnJ1cHRzKHJvY2tjaGlwKTsKKwogCXJldHVybiAwOwogZXJyX2VwY19tZW1fZXhpdDoK
IAlwY2lfZXBjX21lbV9leGl0KGVwYyk7Ci0tIAoyLjM5LjIKCg==

--------------esXA1Txh2YMjp00vl8W3xCHC--
