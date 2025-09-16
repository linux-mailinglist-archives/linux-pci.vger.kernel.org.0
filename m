Return-Path: <linux-pci+bounces-36307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07167B5F832
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03F6328307
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 22:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30D298CB7;
	Tue, 16 Sep 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rYLNrsB8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553E285C95;
	Tue, 16 Sep 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060602; cv=none; b=KUvLlCUk7XIern9B7Ac9Ya4gxmQLdjAaz6KShVy+1aM+Gsi3FXD0FVQKail6eTUoLs/hRiyP3+B8LVQhX5Dgo+8Ew+RMcHqN1zinKj95xp3FVuv8y+3SzQxg0BF0fWm/CSIQKhCAG1GNw47D42fygKUevmilArGy7rQmL5RwRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060602; c=relaxed/simple;
	bh=5ZW7xgclfEVdJBLramF18uiwLPXnLoB2bpXnl8cFvv4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=t53rNPQEfJ2CjjGZYjgqoJkkN9+Ic4iHVN5CuX6VoZhKT1mcjMnXKOlKWBOyRcn00bVoycD8o58MeHk1OeBEQ+7cN8dhNjjPfeUoInvdv5ZtiSaz+JSmyQP2P3u5YL6R0PNkxmfRRveiyDKSWinLYRSDwVbXy5e/S2maxeFqydQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rYLNrsB8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cRGKc3zDtz9t8X;
	Wed, 17 Sep 2025 00:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758060596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xEJEnmpRagi+nUiHPzvm+G7T+hKq5MS0PYsR2dwTg7I=;
	b=rYLNrsB8T6LD6foVbt5jYdzvU6HqFAiAdF4SR+XLlLU4ykOfs1mxR/FHnEfIKCzvk57kD6
	cdSXM0K/UCT2Gq2aXeKnyEf6aRMaVBjrOzjRAA214jpbwE41EXIiTNHbzggb6OvG2ZDrH6
	ocZNUdrrTrXXF2z11TARChevmOkpGs6HWtJL83HINT8izR7e+a3HHNhpHDMCpT+WPsTAZi
	gginmDSM4g+FgIFq1F3sS3knoKgQsb85nkxgccRBnoYesvMhu76uBmt+7HctmmxkZOmYdG
	CBOepyLljNSNuRLnaxRnnjZth+LO2ukv+StwWIqsf1oiXQthFZCN+mC+8Ofplw==
Content-Type: multipart/mixed; boundary="------------5F1ZMUY5Lvr44xoJynSN20Fq"
Message-ID: <643c9b19-dda4-43c5-bb6d-aa0705053d43@mailbox.org>
Date: Wed, 17 Sep 2025 00:09:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Fix inverted break condition in PHY
 initialization
To: Bjorn Helgaas <helgaas@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250916181558.GA1810654@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250916181558.GA1810654@bhelgaas>
X-MBO-RS-ID: 1ad0c2000c055ae463a
X-MBO-RS-META: igaf1iyfcjnetcawoa5n5wo3wnrjeyc8

This is a multi-part message in MIME format.
--------------5F1ZMUY5Lvr44xoJynSN20Fq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 8:15 PM, Bjorn Helgaas wrote:
> On Tue, Sep 16, 2025 at 07:39:07PM +0200, Marek Vasut wrote:
>> On 9/16/25 7:13 PM, Bjorn Helgaas wrote:
>>> On Tue, Sep 16, 2025 at 06:31:31PM +0200, Marek Vasut wrote:
>>>> On 9/16/25 3:57 PM, Geert Uytterhoeven wrote:
>>>>> On Tue, 16 Sept 2025 at 15:39, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>>>> On 9/16/25 11:59 AM, Geert Uytterhoeven wrote:
>>>
>>>>>>> This change looks correct, and fixes the timeout seen on White Hawk
>>>>>>> with CONFIG_DEBUG_LOCK_ALLOC=y.
>>>>>>> However, it causes a crash when CONFIG_DEBUG_LOCK_ALLOC=n:
>>>>>>>
>>>>>>>         SError Interrupt on CPU0, code 0x00000000be000011 -- SError
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>          el1h_64_error_handler+0x2c/0x40
>>>>>>>          el1h_64_error+0x70/0x74
>>>>>>>          dw_pcie_read+0x20/0x74 (P)
>>>>>>>          rcar_gen4_pcie_additional_common_init+0x1c/0x6c
>>>>>>
>>>>>> SError in rcar_gen4_pcie_additional_common_init , this is unrelated to
>>>>>> this fix.
>>>>>>
>>>>>> Does the following patch make this SError go away ?
>>>>>
>>>>>> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>>>> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>>>>>> @@ -204,6 +204,8 @@ static int rcar_gen4_pcie_common_init(struct
>>>>>> rcar_gen4_pcie *rcar)
>>>>>>             if (ret)
>>>>>>                     goto err_unprepare;
>>>>>>
>>>>>> +mdelay(1);
>>>>>> +
>>>>>>             if (rcar->drvdata->additional_common_init)
>>>>>>                     rcar->drvdata->additional_common_init(rcar);
>>>>>>
>>>>>
>>>>> Yes it does, thanks!
>>>>
>>>> So with this one extra mdelay(1), the PCIe is fully good on your side, or is
>>>> there still anything weird/flaky/malfunctioning ?
>>>
>>> Do we have a theory about why this delay is needed?  I assume it's
>>> something specific to the rcar hardware (not something required by the
>>> PCIe base spec)?
>>>
>>> I'm seeing SError interrupts and external aborts on several arm64
>>> systems and I'd like to understand better why they happen and when/if
>>> we can recover from them.
>>
>> The SError here happens when the PWR RST is released and DBI is
>> accessed rapidly right after that. The current hypothesis is, that
>> the controller core needs a bit of time to initialize itself after
>> the reset is released, before DBI access can be performed ; if the
>> DBI access happens too soon after the reset was released, the core
>> reject the access and CPU interprets that as SError.
> 
> Sounds like this SError is for something on the CPU side of the host
> bridge.

Since this only happens when accessing DBI registers shortly after the 
reset was deasserted, it seems that way.

> I've also seen errors that seem to be related to errors on the PCIe
> side, e.g., a PCIe Completion Timeout or Unsupported Request.  On most
> platforms, those result in writes being silently dropped or ~0 data
> being synthesized for reads.
> 
> E.g., this SError that seems related to a BAR programming issue:
> https://lore.kernel.org/linux-pci/86plf0lgit.fsf@scott-ph-mail.amperecomputing.com/

The SError is reported for basically almost any AXI bus error, some IO 
operation happened and it didn't complete or some such, so it is 
expected to see a lot of disparate SErrors like that.

In this case, it isn't anything on the bridge side yet, the bridge isn't 
even fully configured and the link is down when the SError happens here.

>> The reference manual however does not list any such delay, which
>> makes me concerned. I can send such a patch which adds the mdelay(1)
>> as a temporary stopgap fix, until some better explanation maybe
>> sometimes gets uncovered, if that would be OK ?
> 
> Yeah, if it's some rcar-specific thing, I don't see a better
> alternative.
I have one more hypothesis.

I noticed in V4H RM rev.1.30 page 798 that CPG (reset) and PCIe are on 
different busses. From CA76, the CPG reset is reachable via "CCI->Slave 
Access BUS->CPG" and PCIe is reachable via "CCI->Slave Access BUS->HSC".

I wonder if a sequence like this:
- writel(CPG un-reset register)
- readl(PCI DBI register)
can, due to bus behavior, lead to readl(PCI DBI register) taking effect 
on the PCIe IP _before_ the writel(CPG un-reset register) takes effect 
on the CPG IP, which trigger the SError (coming from PCIe IP).

Or is it guaranteed that writel(some IP) followed by readl(another IP) 
are strictly ordered in this manner even on the IP end at which they 
arrive, even if the two IPs are on different busses ? Please pardon my 
ignorance.

Does the attached diff also help Geert with the SError ?

Same diff is also inline below:

"
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c 
b/drivers/clk/renesas/renesas-cpg-mssr.c
index be9f59e6975d..cb380ba20141 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -688,12 +688,14 @@ static int cpg_mssr_reset(struct 
reset_controller_dev *rcdev,

  	/* Reset module */
  	writel(bitmask, priv->pub.base0 + priv->reset_regs[reg]);
+	readl(priv->pub.base0 + priv->reset_regs[reg]);

  	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
  	udelay(35);

  	/* Release module from reset state */
  	writel(bitmask, priv->pub.base0 + priv->reset_clear_regs[reg]);
+	readl(priv->pub.base0 + priv->reset_clear_regs[reg]);

  	return 0;
  }
@@ -708,6 +710,7 @@ static int cpg_mssr_assert(struct 
reset_controller_dev *rcdev, unsigned long id)
  	dev_dbg(priv->dev, "assert %u%02u\n", reg, bit);

  	writel(bitmask, priv->pub.base0 + priv->reset_regs[reg]);
+	readl(priv->pub.base0 + priv->reset_regs[reg]);
  	return 0;
  }

@@ -722,6 +725,7 @@ static int cpg_mssr_deassert(struct 
reset_controller_dev *rcdev,
  	dev_dbg(priv->dev, "deassert %u%02u\n", reg, bit);

  	writel(bitmask, priv->pub.base0 + priv->reset_clear_regs[reg]);
+	readl(priv->pub.base0 + priv->reset_clear_regs[reg]);
  	return 0;
  }

"
--------------5F1ZMUY5Lvr44xoJynSN20Fq
Content-Type: text/x-patch; charset=UTF-8; name="reset.diff"
Content-Disposition: attachment; filename="reset.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcmVuZXNhcy1jcGctbXNzci5jIGIv
ZHJpdmVycy9jbGsvcmVuZXNhcy9yZW5lc2FzLWNwZy1tc3NyLmMKaW5kZXggYmU5ZjU5ZTY5
NzVkLi5jYjM4MGJhMjAxNDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcmVu
ZXNhcy1jcGctbXNzci5jCisrKyBiL2RyaXZlcnMvY2xrL3JlbmVzYXMvcmVuZXNhcy1jcGct
bXNzci5jCkBAIC02ODgsMTIgKzY4OCwxNCBAQCBzdGF0aWMgaW50IGNwZ19tc3NyX3Jlc2V0
KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsCiAKIAkvKiBSZXNldCBtb2R1
bGUgKi8KIAl3cml0ZWwoYml0bWFzaywgcHJpdi0+cHViLmJhc2UwICsgcHJpdi0+cmVzZXRf
cmVnc1tyZWddKTsKKwlyZWFkbChwcml2LT5wdWIuYmFzZTAgKyBwcml2LT5yZXNldF9yZWdz
W3JlZ10pOwogCiAJLyogV2FpdCBmb3IgYXQgbGVhc3Qgb25lIGN5Y2xlIG9mIHRoZSBSQ0xL
IGNsb2NrIChAIGNhLiAzMiBrSHopICovCiAJdWRlbGF5KDM1KTsKIAogCS8qIFJlbGVhc2Ug
bW9kdWxlIGZyb20gcmVzZXQgc3RhdGUgKi8KIAl3cml0ZWwoYml0bWFzaywgcHJpdi0+cHVi
LmJhc2UwICsgcHJpdi0+cmVzZXRfY2xlYXJfcmVnc1tyZWddKTsKKwlyZWFkbChwcml2LT5w
dWIuYmFzZTAgKyBwcml2LT5yZXNldF9jbGVhcl9yZWdzW3JlZ10pOwogCiAJcmV0dXJuIDA7
CiB9CkBAIC03MDgsNiArNzEwLDcgQEAgc3RhdGljIGludCBjcGdfbXNzcl9hc3NlcnQoc3Ry
dWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwgdW5zaWduZWQgbG9uZyBpZCkKIAlk
ZXZfZGJnKHByaXYtPmRldiwgImFzc2VydCAldSUwMnVcbiIsIHJlZywgYml0KTsKIAogCXdy
aXRlbChiaXRtYXNrLCBwcml2LT5wdWIuYmFzZTAgKyBwcml2LT5yZXNldF9yZWdzW3JlZ10p
OworCXJlYWRsKHByaXYtPnB1Yi5iYXNlMCArIHByaXYtPnJlc2V0X3JlZ3NbcmVnXSk7CiAJ
cmV0dXJuIDA7CiB9CiAKQEAgLTcyMiw2ICs3MjUsNyBAQCBzdGF0aWMgaW50IGNwZ19tc3Ny
X2RlYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsCiAJZGV2X2Ri
Zyhwcml2LT5kZXYsICJkZWFzc2VydCAldSUwMnVcbiIsIHJlZywgYml0KTsKIAogCXdyaXRl
bChiaXRtYXNrLCBwcml2LT5wdWIuYmFzZTAgKyBwcml2LT5yZXNldF9jbGVhcl9yZWdzW3Jl
Z10pOworCXJlYWRsKHByaXYtPnB1Yi5iYXNlMCArIHByaXYtPnJlc2V0X2NsZWFyX3JlZ3Nb
cmVnXSk7CiAJcmV0dXJuIDA7CiB9CiAK

--------------5F1ZMUY5Lvr44xoJynSN20Fq--

