Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48834581C78
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 01:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239972AbiGZXlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 19:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiGZXlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 19:41:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA011C0E;
        Tue, 26 Jul 2022 16:41:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so1841221pjz.1;
        Tue, 26 Jul 2022 16:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=pDvQd6qTx5v5vhMo86TIw3OfQS6b8AVZvUNa/LsQYnY=;
        b=m3rOWVyipyVVXXWdH6juCG9cNpSzl0P2sZWMtwFT28gtXZ5Zlpq6WaANc48xyMMxc3
         7Z2fR9yY/6t7GRJoTxV6BqDjLzIO9UHbkz725Is/7TgVsKJxXcIAVkVE0x+SVr23ms6C
         lB1VyXY+sojJBow2eubVR70iDZ1InSGWj0EY1/9WhBTnEKgYFmwaeeHaG2sKZetYspUN
         p/bEA+SDUmc0/ocm3lQvN575E7tjWhkGTa0ojFFNqErxlYDY6rkG2e0O3bGC8zHvWUtH
         Tdjz9/R5blU9352sx/1+NLuBgfMPuneXu/r4cpXGTq9XH+VxrkhReUFdo1XYsGWGn5/C
         aTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=pDvQd6qTx5v5vhMo86TIw3OfQS6b8AVZvUNa/LsQYnY=;
        b=LYsKAzXWICslij+TfjwR99+VzrCoO0+ZMRsXBSZkNRfQMorJfE6XKsaBta4BFcx8GJ
         Vht7meuZRSFMpHHZ+6Gbdf96kfrf2/Cqo8Sgn6TaIqv3F6n5fyEyAFgPznaSh3dEeRok
         hfg0hHiOnOAK9fC16LjKnfJFF1XbPnKv/ErY76TYYcnbJgkBOiLP4+qeOWixx+dqj9L6
         TeZWIvLUpa6SMLRToYmPq6RFRGLWkSTXzoJH/iGjVRGgVAJ6rZ72HfFMCXOjY6rUXd6w
         qAAjIrf+7YFem18MNskzTXKm8xF9q5IxIN7bKqH1Iuk3+eCiC9vSTQVO5oNAhR+1VtYI
         Xa7A==
X-Gm-Message-State: AJIora+d0kUEveKb5K353xoNUSeXMostUfEh+jMSCYQ0uEJ0oGZixVw2
        qCtUVW3wGPzkNOcWSahafVY=
X-Google-Smtp-Source: AGRyM1t1qC8MV9QIF+hA1BfupMp76UR5fyEv0cXD/0pHmg7VpJCth9ZFz9S6Qwc55wWvmD3Y1nlNrg==
X-Received: by 2002:a17:90a:fd04:b0:1f3:77d:21d8 with SMTP id cv4-20020a17090afd0400b001f3077d21d8mr973055pjb.81.1658878871585;
        Tue, 26 Jul 2022 16:41:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id co2-20020a17090afe8200b001f1a8c24b5esm168252pjb.6.2022.07.26.16.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 16:41:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Wa970GY1Ay1PM7HnGadRSOBg"
Message-ID: <4af7c132-1100-3d48-2311-e6be3bdf3629@gmail.com>
Date:   Tue, 26 Jul 2022 16:41:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/7] PCI: brcmstb: Re-submit reverted patchset
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20220726220303.GA109624@bhelgaas>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220726220303.GA109624@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a multi-part message in MIME format.
--------------Wa970GY1Ay1PM7HnGadRSOBg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/22 15:03, Bjorn Helgaas wrote:
> On Mon, Jul 25, 2022 at 11:12:49AM -0400, Jim Quinlan wrote:
>> ...
>> Jim Quinlan (7):
>>   PCI: brcmstb: Remove unnecessary forward declarations
>>   PCI: brcmstb: Split brcm_pcie_setup() into two funcs
>>   PCI: brcmstb: Gate config space access on link status
>>   PCI: brcmstb: Add mechanism to turn on subdev regulators
>>   PCI: brcmstb: Add control of subdevice voltage regulators
>>   PCI: brcmstb: Do not turn off WOL regulators on suspend
>>   PCI: brcmstb: Have .map_bus function names end with 'map_bus'
>>
>>  drivers/pci/controller/pcie-brcmstb.c | 476 ++++++++++++++++++--------
>>  1 file changed, 341 insertions(+), 135 deletions(-)
> 
> I reworked these and put them on pci/ctrl/brcm for v5.20.  This is a
> proposal, not something set in stone.  But time is of the essence to
> figure out how we want to proceed.
> 
> I changed a lot of stuff and it's likely I broke something in the
> process, so please take a look and test this out.  Here's an outline
> of what I changed:
> 
>   - Moved the config access "link up" check earlier because it's not
>     related to the power regulator patches.
> 
>   - Changed config access "link up" checks to use PCIE_ECAM_REG()
>     instead of hard-coding 0xfff masks.  The 32-bit accessors already
>     mask out the low two bits, so we don't need to do that here.
> 
>   - Squashed pci_subdev_regulators_add_bus() directly into
>     brcm_pcie_add_bus() for readability.  Similarly for
>     pci_subdev_regulators_remove_bus().
> 
>   - This makes a clear split between:
> 
>     * A patch that adds get/enable of regulators, and starting the
>       link after enabling regulators, and
> 
>     * A patch that disables/enables regulators for suspend/resume.
> 
>   - Since we only support one set of subregulator info (for one Root
>     Port, and brcm_pcie_suspend_noirq() depends on this since it uses
>     the pcie->sr pointer), use pcie->sr always instead of
>     dev->driver_data.
> 
>   - Squashed wakeup device checking into the suspend/resume patch so
>     there's not a time when suspend might turn off power to a wakeup
>     device.
> 
>   - Renamed brcm_pcie_map_bus32() to brcm7425_pcie_map_bus() so it
>     ends in "_map_bus()" like other drivers.  Also,
>     brcm7425_pcie_map_bus() doesn't actually depend on the 32-bitness.

Attached is the diff between Jim's and your branch just so it is easier to see what moved around.

Initial testing on an ARCH_BRCMSTB system with PCIe appears to be good, we don't have any regulator on that board so the dummy ones get picked up which is expected. Same thing with a Raspberry Pi 4B system.

I could unbind and bind again and there were no reference count leaks on the regulators, so this looks good to me.

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

of course, we should have Jim's test results as well as Cyril's ideally to make sure there are no regressions on the CM4 board.

Thanks Bjorn!
-- 
Florian
--------------Wa970GY1Ay1PM7HnGadRSOBg
Content-Type: text/x-patch; charset=UTF-8; name="jq-vs-bh.diff"
Content-Disposition: attachment; filename="jq-vs-bh.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1icmNtc3RiLmMgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtYnJjbXN0Yi5jCmluZGV4IGI0MDczM2RkMjUz
Yy4uNTIxYWNkNjMyZjFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtYnJjbXN0Yi5jCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1icmNtc3Ri
LmMKQEAgLTI2MSw3ICsyNjEsNiBAQCBzdHJ1Y3QgYnJjbV9wY2llIHsKIAl1MzIJCQlod19y
ZXY7CiAJdm9pZAkJCSgqcGVyc3Rfc2V0KShzdHJ1Y3QgYnJjbV9wY2llICpwY2llLCB1MzIg
dmFsKTsKIAl2b2lkCQkJKCpicmlkZ2Vfc3dfaW5pdF9zZXQpKHN0cnVjdCBicmNtX3BjaWUg
KnBjaWUsIHUzMiB2YWwpOwotCWJvb2wJCQlyZWd1bGF0b3Jfb29wczsKIAlzdHJ1Y3Qgc3Vi
ZGV2X3JlZ3VsYXRvcnMgKnNyOwogCWJvb2wJCQllcF93YWtldXBfY2FwYWJsZTsKIH07CkBA
IC02ODUsOCArNjg0LDggQEAgc3RhdGljIGJvb2wgYnJjbV9wY2llX2xpbmtfdXAoc3RydWN0
IGJyY21fcGNpZSAqcGNpZSkKIAlyZXR1cm4gZGxhICYmIHBsdTsKIH0KIAotc3RhdGljIHZv
aWQgX19pb21lbSAqYnJjbV9wY2llX21hcF9idXMoc3RydWN0IHBjaV9idXMgKmJ1cywgdW5z
aWduZWQgaW50IGRldmZuLAotCQkJCQlpbnQgd2hlcmUpCitzdGF0aWMgdm9pZCBfX2lvbWVt
ICpicmNtX3BjaWVfbWFwX2J1cyhzdHJ1Y3QgcGNpX2J1cyAqYnVzLAorCQkJCSAgICAgICB1
bnNpZ25lZCBpbnQgZGV2Zm4sIGludCB3aGVyZSkKIHsKIAlzdHJ1Y3QgYnJjbV9wY2llICpw
Y2llID0gYnVzLT5zeXNkYXRhOwogCXZvaWQgX19pb21lbSAqYmFzZSA9IHBjaWUtPmJhc2U7
CkBAIC02OTQsNyArNjkzLDcgQEAgc3RhdGljIHZvaWQgX19pb21lbSAqYnJjbV9wY2llX21h
cF9idXMoc3RydWN0IHBjaV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRldmZuLAogCiAJLyog
QWNjZXNzZXMgdG8gdGhlIFJDIGdvIHJpZ2h0IHRvIHRoZSBSQyByZWdpc3RlcnMgaWYgIWRl
dmZuICovCiAJaWYgKHBjaV9pc19yb290X2J1cyhidXMpKQotCQlyZXR1cm4gZGV2Zm4gPyBO
VUxMIDogYmFzZSArICh3aGVyZSAmIDB4ZmZmKTsKKwkJcmV0dXJuIGRldmZuID8gTlVMTCA6
IGJhc2UgKyBQQ0lFX0VDQU1fUkVHKHdoZXJlKTsKIAogCS8qIEFuIGFjY2VzcyB0byBvdXIg
SFcgdy9vIGxpbmstdXAgd2lsbCBjYXVzZSBhIENQVSBBYm9ydCAqLwogCWlmICghYnJjbV9w
Y2llX2xpbmtfdXAocGNpZSkpCkBAIC03MDMsMTEgKzcwMiwxMSBAQCBzdGF0aWMgdm9pZCBf
X2lvbWVtICpicmNtX3BjaWVfbWFwX2J1cyhzdHJ1Y3QgcGNpX2J1cyAqYnVzLCB1bnNpZ25l
ZCBpbnQgZGV2Zm4sCiAJLyogRm9yIGRldmljZXMsIHdyaXRlIHRvIHRoZSBjb25maWcgc3Bh
Y2UgaW5kZXggcmVnaXN0ZXIgKi8KIAlpZHggPSBQQ0lFX0VDQU1fT0ZGU0VUKGJ1cy0+bnVt
YmVyLCBkZXZmbiwgMCk7CiAJd3JpdGVsKGlkeCwgcGNpZS0+YmFzZSArIFBDSUVfRVhUX0NG
R19JTkRFWCk7Ci0JcmV0dXJuIGJhc2UgKyBQQ0lFX0VYVF9DRkdfREFUQSArICh3aGVyZSAm
IDB4ZmZmKTsKKwlyZXR1cm4gYmFzZSArIFBDSUVfRVhUX0NGR19EQVRBICsgUENJRV9FQ0FN
X1JFRyh3aGVyZSk7CiB9CiAKLXN0YXRpYyB2b2lkIF9faW9tZW0gKmJyY21fcGNpZV9tYXBf
YnVzMzIoc3RydWN0IHBjaV9idXMgKmJ1cywgdW5zaWduZWQgaW50IGRldmZuLAotCQkJCQkg
aW50IHdoZXJlKQorc3RhdGljIHZvaWQgX19pb21lbSAqYnJjbTc0MjVfcGNpZV9tYXBfYnVz
KHN0cnVjdCBwY2lfYnVzICpidXMsCisJCQkJCSAgIHVuc2lnbmVkIGludCBkZXZmbiwgaW50
IHdoZXJlKQogewogCXN0cnVjdCBicmNtX3BjaWUgKnBjaWUgPSBidXMtPnN5c2RhdGE7CiAJ
dm9pZCBfX2lvbWVtICpiYXNlID0gcGNpZS0+YmFzZTsKQEAgLTcxNSwxNCArNzE0LDE0IEBA
IHN0YXRpYyB2b2lkIF9faW9tZW0gKmJyY21fcGNpZV9tYXBfYnVzMzIoc3RydWN0IHBjaV9i
dXMgKmJ1cywgdW5zaWduZWQgaW50IGRldmZuCiAKIAkvKiBBY2Nlc3NlcyB0byB0aGUgUkMg
Z28gcmlnaHQgdG8gdGhlIFJDIHJlZ2lzdGVycyBpZiAhZGV2Zm4gKi8KIAlpZiAocGNpX2lz
X3Jvb3RfYnVzKGJ1cykpCi0JCXJldHVybiBkZXZmbiA/IE5VTEwgOiBiYXNlICsgKHdoZXJl
ICYgMHhmZmMpOworCQlyZXR1cm4gZGV2Zm4gPyBOVUxMIDogYmFzZSArIFBDSUVfRUNBTV9S
RUcod2hlcmUpOwogCiAJLyogQW4gYWNjZXNzIHRvIG91ciBIVyB3L28gbGluay11cCB3aWxs
IGNhdXNlIGEgQ1BVIEFib3J0ICovCiAJaWYgKCFicmNtX3BjaWVfbGlua191cChwY2llKSkK
IAkJcmV0dXJuIE5VTEw7CiAKIAkvKiBGb3IgZGV2aWNlcywgd3JpdGUgdG8gdGhlIGNvbmZp
ZyBzcGFjZSBpbmRleCByZWdpc3RlciAqLwotCWlkeCA9IFBDSUVfRUNBTV9PRkZTRVQoYnVz
LT5udW1iZXIsIGRldmZuLCAod2hlcmUgJiAweGZmYykpOworCWlkeCA9IFBDSUVfRUNBTV9P
RkZTRVQoYnVzLT5udW1iZXIsIGRldmZuLCB3aGVyZSk7CiAJd3JpdGVsKGlkeCwgYmFzZSAr
IElEWF9BRERSKHBjaWUpKTsKIAlyZXR1cm4gYmFzZSArIERBVEFfQUREUihwY2llKTsKIH0K
QEAgLTEwODIsOCArMTA4MSw4IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3Qgc3VwcGxp
ZXNbXSA9IHsKIAogc3RhdGljIHZvaWQgKmFsbG9jX3N1YmRldl9yZWd1bGF0b3JzKHN0cnVj
dCBkZXZpY2UgKmRldikKIHsKLQljb25zdCBzaXplX3Qgc2l6ZSA9IHNpemVvZihzdHJ1Y3Qg
c3ViZGV2X3JlZ3VsYXRvcnMpCi0JCSsgc2l6ZW9mKHN0cnVjdCByZWd1bGF0b3JfYnVsa19k
YXRhKSAqIEFSUkFZX1NJWkUoc3VwcGxpZXMpOworCWNvbnN0IHNpemVfdCBzaXplID0gc2l6
ZW9mKHN0cnVjdCBzdWJkZXZfcmVndWxhdG9ycykgKworCQlzaXplb2Yoc3RydWN0IHJlZ3Vs
YXRvcl9idWxrX2RhdGEpICogQVJSQVlfU0laRShzdXBwbGllcyk7CiAJc3RydWN0IHN1YmRl
dl9yZWd1bGF0b3JzICpzcjsKIAlpbnQgaTsKIApAQCAtMTA5Nyw5NSArMTA5Niw1NyBAQCBz
dGF0aWMgdm9pZCAqYWxsb2Nfc3ViZGV2X3JlZ3VsYXRvcnMoc3RydWN0IGRldmljZSAqZGV2
KQogCXJldHVybiBzcjsKIH0KIAotc3RhdGljIGludCBwY2lfc3ViZGV2X3JlZ3VsYXRvcnNf
YWRkX2J1cyhzdHJ1Y3QgcGNpX2J1cyAqYnVzKQorc3RhdGljIGludCBicmNtX3BjaWVfYWRk
X2J1cyhzdHJ1Y3QgcGNpX2J1cyAqYnVzKQogeworCXN0cnVjdCBicmNtX3BjaWUgKnBjaWUg
PSBidXMtPnN5c2RhdGE7CiAJc3RydWN0IGRldmljZSAqZGV2ID0gJmJ1cy0+ZGV2OwogCXN0
cnVjdCBzdWJkZXZfcmVndWxhdG9ycyAqc3I7CiAJaW50IHJldDsKIAotCXNyID0gYWxsb2Nf
c3ViZGV2X3JlZ3VsYXRvcnMoZGV2KTsKLQlpZiAoIXNyKQotCQlyZXR1cm4gLUVOT01FTTsK
LQotCXJldCA9IHJlZ3VsYXRvcl9idWxrX2dldChkZXYsIHNyLT5udW1fc3VwcGxpZXMsIHNy
LT5zdXBwbGllcyk7Ci0JaWYgKHJldCkgewotCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBn
ZXQgcmVndWxhdG9ycyBmb3IgZG93bnN0cmVhbSBkZXZpY2VcbiIpOwotCQlyZXR1cm4gcmV0
OwotCX0KLQotCXJldCA9IHJlZ3VsYXRvcl9idWxrX2VuYWJsZShzci0+bnVtX3N1cHBsaWVz
LCBzci0+c3VwcGxpZXMpOwotCWlmIChyZXQpIHsKLQkJZGV2X2VycihkZXYsICJmYWlsZWQg
dG8gZW5hYmxlIHJlZ3VsYXRvcnMgZm9yIGRvd25zdHJlYW0gZGV2aWNlXG4iKTsKLQkJcmVn
dWxhdG9yX2J1bGtfZnJlZShzci0+bnVtX3N1cHBsaWVzLCBzci0+c3VwcGxpZXMpOwotCQly
ZXR1cm4gcmV0OwotCX0KLQlkZXYtPmRyaXZlcl9kYXRhID0gc3I7Ci0KLQlyZXR1cm4gMDsK
LX0KKwlpZiAoIWJ1cy0+cGFyZW50IHx8ICFwY2lfaXNfcm9vdF9idXMoYnVzLT5wYXJlbnQp
KQorCQlyZXR1cm4gMDsKIAotc3RhdGljIGludCBicmNtX3BjaWVfYWRkX2J1cyhzdHJ1Y3Qg
cGNpX2J1cyAqYnVzKQotewotCXN0cnVjdCBicmNtX3BjaWUgKnBjaWUgPSAoc3RydWN0IGJy
Y21fcGNpZSAqKSBidXMtPnN5c2RhdGE7Ci0Jc3RydWN0IGRldmljZSAqZGV2ID0gJmJ1cy0+
ZGV2OwotCWludCByZXQ7CisJaWYgKGRldi0+b2Zfbm9kZSkgeworCQlzciA9IGFsbG9jX3N1
YmRldl9yZWd1bGF0b3JzKGRldik7CisJCWlmICghc3IpIHsKKwkJCWRldl9pbmZvKGRldiwg
IkNhbid0IGFsbG9jYXRlIHJlZ3VsYXRvcnMgZm9yIGRvd25zdHJlYW0gZGV2aWNlXG4iKTsK
KwkJCWdvdG8gbm9fcmVndWxhdG9yczsKKwkJfQogCi0JaWYgKCFidXMtPnBhcmVudCB8fCAh
cGNpX2lzX3Jvb3RfYnVzKGJ1cy0+cGFyZW50KSB8fCAhcGNpZSkKLQkJcmV0dXJuIDA7CisJ
CXBjaWUtPnNyID0gc3I7CiAKLQlpZiAoZGV2LT5vZl9ub2RlICYmIGRldi0+ZHJpdmVyX2Rh
dGEpIHsKLQkJLyoKLQkJICogT29wcywgdGhpcyBpcyB1bmZvcnR1bmF0ZS4gIFdlIGFyZSB1
c2luZyB0aGUgcG9ydAotCQkgKiBkcml2ZXIncyBkcml2ZXJfZGF0YSBmaWVsZCB0byBzdG9y
ZSBvdXIgcmVndWxhdG9yIGluZm8KLQkJICogYW5kIGl0IGFwcGVhcnMgdGhhdCBhbm90aGVy
IGRyaXZlciBzdGFydGVkIHVzaW5nIGl0IGFzCi0JCSAqIHdlbGwuICBJZiBzbywgYmUgYSB0
ZWFtIHBsYXllciBkbyBub3Qgb3ZlcndyaXRlIGl0LiAgV2UKLQkJICogbWF5IHN0aWxsIGJl
IG9rYXkgaWYgdGhlcmUgYXJlIG5vIHJlZ3VsYXRvcnMuCi0JCSAqLwotCQlkZXZfZXJyKGRl
diwgInJvb3QgcG9ydCBkZXYuZHJpdmVyX2RhdGEgbm9uLU5VTEw7IHNvbWV0aGluZyB3cm9u
Z1xuIik7CisJCXJldCA9IHJlZ3VsYXRvcl9idWxrX2dldChkZXYsIHNyLT5udW1fc3VwcGxp
ZXMsIHNyLT5zdXBwbGllcyk7CisJCWlmIChyZXQpIHsKKwkJCWRldl9pbmZvKGRldiwgIk5v
IHJlZ3VsYXRvcnMgZm9yIGRvd25zdHJlYW0gZGV2aWNlXG4iKTsKKwkJCWdvdG8gbm9fcmVn
dWxhdG9yczsKKwkJfQogCi0JfSBlbHNlIGlmIChkZXYtPm9mX25vZGUpIHsKLQkJcmV0ID0g
cGNpX3N1YmRldl9yZWd1bGF0b3JzX2FkZF9idXMoYnVzKTsKLQkJLyogR3JhYiB0aGUgcmVn
dWxhdG9ycyBmb3Igc3VzcGVuZC9yZXN1bWUgKi8KLQkJcGNpZS0+c3IgPSBidXMtPmRldi5k
cml2ZXJfZGF0YTsKKwkJcmV0ID0gcmVndWxhdG9yX2J1bGtfZW5hYmxlKHNyLT5udW1fc3Vw
cGxpZXMsIHNyLT5zdXBwbGllcyk7CisJCWlmIChyZXQpIHsKKwkJCWRldl9lcnIoZGV2LCAi
Q2FuJ3QgZW5hYmxlIHJlZ3VsYXRvcnMgZm9yIGRvd25zdHJlYW0gZGV2aWNlXG4iKTsKKwkJ
CXJlZ3VsYXRvcl9idWxrX2ZyZWUoc3ItPm51bV9zdXBwbGllcywgc3ItPnN1cHBsaWVzKTsK
KwkJCXBjaWUtPnNyID0gTlVMTDsKKwkJfQogCX0KIAotCS8qIFRyeSB0byBzdGFydCB0aGUg
bGluay4gKi8KK25vX3JlZ3VsYXRvcnM6CiAJYnJjbV9wY2llX3N0YXJ0X2xpbmsocGNpZSk7
Ci0KLQkvKgotCSAqIFRoZXJlIGlzIG5vdCBtdWNoIG9mIGEgcG9pbnQgdG8gcmV0dXJuIGFu
IGVycm9yIGFzIGN1cnJlbnRseSBpdAotCSAqIHdpbGwgY2F1c2UgYSBXQVJOSU5HKCkgZnJv
bSBwY2lfYWxsb2NfY2hpbGRfYnVzKCkuICBTbyBvbmx5Ci0JICogcmV0dXJuIHRoZSBlcnJv
ciBpZiBpdCBpcyAtRU5PTUVNLiAgTm90ZSB0aGF0IHdlIGFyZSBhbHdheXMKLQkgKiBkb2lu
ZyBhIGRldl9lcnIoKSBmb3Igb3RoZXIgZXJyb3MuCi0JICovCi0JcmV0dXJuIHJldCA9PSAt
RU5PTUVNID8gcmV0IDogMDsKLX0KLQotc3RhdGljIHZvaWQgcGNpX3N1YmRldl9yZWd1bGF0
b3JzX3JlbW92ZV9idXMoc3RydWN0IHBjaV9idXMgKmJ1cykKLXsKLQlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSAmYnVzLT5kZXY7Ci0Jc3RydWN0IHN1YmRldl9yZWd1bGF0b3JzICpzciA9IGRl
di0+ZHJpdmVyX2RhdGE7Ci0KLQlpZiAocmVndWxhdG9yX2J1bGtfZGlzYWJsZShzci0+bnVt
X3N1cHBsaWVzLCBzci0+c3VwcGxpZXMpKQotCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBk
aXNhYmxlIHJlZ3VsYXRvcnMgZm9yIGRvd25zdHJlYW0gZGV2aWNlXG4iKTsKLQlyZWd1bGF0
b3JfYnVsa19mcmVlKHNyLT5udW1fc3VwcGxpZXMsIHNyLT5zdXBwbGllcyk7Ci0JZGV2LT5k
cml2ZXJfZGF0YSA9IE5VTEw7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyB2b2lkIGJyY21f
cGNpZV9yZW1vdmVfYnVzKHN0cnVjdCBwY2lfYnVzICpidXMpCiB7CisJc3RydWN0IGJyY21f
cGNpZSAqcGNpZSA9IGJ1cy0+c3lzZGF0YTsKKwlzdHJ1Y3Qgc3ViZGV2X3JlZ3VsYXRvcnMg
KnNyID0gcGNpZS0+c3I7CiAJc3RydWN0IGRldmljZSAqZGV2ID0gJmJ1cy0+ZGV2OwotCXN0
cnVjdCBicmNtX3BjaWUgKnBjaWU7CiAKLQlpZiAoIWRldi0+b2Zfbm9kZSB8fCAhZGV2LT5k
cml2ZXJfZGF0YSB8fCAhYnVzLT5wYXJlbnQgfHwKLQkgICAgIXBjaV9pc19yb290X2J1cyhi
dXMtPnBhcmVudCkpCisJaWYgKCFzcikKIAkJcmV0dXJuOwogCi0JcGNpZSA9IChzdHJ1Y3Qg
YnJjbV9wY2llICopIGJ1cy0+c3lzZGF0YTsKLQlpZiAocGNpZSAmJiBwY2llLT5zcikgewot
CQlwY2lfc3ViZGV2X3JlZ3VsYXRvcnNfcmVtb3ZlX2J1cyhidXMpOwotCQlwY2llLT5zciA9
IE5VTEw7Ci0JfQorCWlmIChyZWd1bGF0b3JfYnVsa19kaXNhYmxlKHNyLT5udW1fc3VwcGxp
ZXMsIHNyLT5zdXBwbGllcykpCisJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGRpc2FibGUg
cmVndWxhdG9ycyBmb3IgZG93bnN0cmVhbSBkZXZpY2VcbiIpOworCXJlZ3VsYXRvcl9idWxr
X2ZyZWUoc3ItPm51bV9zdXBwbGllcywgc3ItPnN1cHBsaWVzKTsKKwlwY2llLT5zciA9IE5V
TEw7CiB9CiAKIC8qIEwyMyBpcyBhIGxvdy1wb3dlciBQQ0llIGxpbmsgc3RhdGUgKi8KQEAg
LTEyOTAsNyArMTI1MSw3IEBAIHN0YXRpYyBpbnQgcGNpX2Rldl9tYXlfd2FrZXVwKHN0cnVj
dCBwY2lfZGV2ICpkZXYsIHZvaWQgKmRhdGEpCiAKIAlpZiAoZGV2aWNlX21heV93YWtldXAo
JmRldi0+ZGV2KSkgewogCQkqcmV0ID0gdHJ1ZTsKLQkJZGV2X2luZm8oJmRldi0+ZGV2LCAi
ZGlzYWJsZSBjYW5jZWxsZWQgZm9yIHdha2UtdXAgZGV2aWNlXG4iKTsKKwkJZGV2X2luZm8o
JmRldi0+ZGV2LCAiUG9zc2libGUgd2FrZS11cCBkZXZpY2U7IHJlZ3VsYXRvcnMgd2lsbCBu
b3QgYmUgZGlzYWJsZWRcbiIpOwogCX0KIAlyZXR1cm4gKGludCkgKnJldDsKIH0KQEAgLTE1
MTMsMTUgKzE0NzQsMTUgQEAgc3RhdGljIHN0cnVjdCBwY2lfb3BzIGJyY21fcGNpZV9vcHMg
PSB7CiAJLnJlYWQgPSBwY2lfZ2VuZXJpY19jb25maWdfcmVhZCwKIAkud3JpdGUgPSBwY2lf
Z2VuZXJpY19jb25maWdfd3JpdGUsCiAJLmFkZF9idXMgPSBicmNtX3BjaWVfYWRkX2J1cywK
LQkucmVtb3ZlX2J1cyA9IGJyY21fcGNpZV9yZW1vdmVfYnVzCisJLnJlbW92ZV9idXMgPSBi
cmNtX3BjaWVfcmVtb3ZlX2J1cywKIH07CiAKLXN0YXRpYyBzdHJ1Y3QgcGNpX29wcyBicmNt
X3BjaWVfb3BzMzIgPSB7Ci0JLm1hcF9idXMgPSBicmNtX3BjaWVfbWFwX2J1czMyLAorc3Rh
dGljIHN0cnVjdCBwY2lfb3BzIGJyY203NDI1X3BjaWVfb3BzID0geworCS5tYXBfYnVzID0g
YnJjbTc0MjVfcGNpZV9tYXBfYnVzLAogCS5yZWFkID0gcGNpX2dlbmVyaWNfY29uZmlnX3Jl
YWQzMiwKIAkud3JpdGUgPSBwY2lfZ2VuZXJpY19jb25maWdfd3JpdGUzMiwKIAkuYWRkX2J1
cyA9IGJyY21fcGNpZV9hZGRfYnVzLAotCS5yZW1vdmVfYnVzID0gYnJjbV9wY2llX3JlbW92
ZV9idXMKKwkucmVtb3ZlX2J1cyA9IGJyY21fcGNpZV9yZW1vdmVfYnVzLAogfTsKIAogc3Rh
dGljIGludCBicmNtX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
QEAgLTE2MTAsNyArMTU3MSw3IEBAIHN0YXRpYyBpbnQgYnJjbV9wY2llX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCX0KIAl9CiAKLQlicmlkZ2UtPm9wcyA9IHBj
aWUtPnR5cGUgPT0gQkNNNzQyNSA/ICZicmNtX3BjaWVfb3BzMzIgOiAmYnJjbV9wY2llX29w
czsKKwlicmlkZ2UtPm9wcyA9IHBjaWUtPnR5cGUgPT0gQkNNNzQyNSA/ICZicmNtNzQyNV9w
Y2llX29wcyA6ICZicmNtX3BjaWVfb3BzOwogCWJyaWRnZS0+c3lzZGF0YSA9IHBjaWU7CiAK
IAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBwY2llKTsK

--------------Wa970GY1Ay1PM7HnGadRSOBg--
