Return-Path: <linux-pci+bounces-728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B573680B9B8
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B41280D81
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BC85384;
	Sun, 10 Dec 2023 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="TuzL3WLf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sXSg/dDM"
X-Original-To: linux-pci@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF11EA;
	Sun, 10 Dec 2023 00:03:10 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 107CA320015C;
	Sun, 10 Dec 2023 03:03:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 10 Dec 2023 03:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm1; t=1702195386; x=
	1702281786; bh=GMzfRuXTuCfqfXxuEBxu13Ipz45Rfi5cs2KL7JIR5Eg=; b=T
	uzL3WLfJyZzQWmhU9ll7OhEgod/EZ81kGPLqML3igABp1qB4KpKfqQAO7gcTK5Zv
	5yicr8x66PhxkEYX/tlI5905lBu3gog7rYkn09CqbBEBD3NE6mRYDtgkYeaeA48P
	S7zMM6yMTgt5pBr5jql19ZVUCVghMUKeGiSIivTiCf297norB6Va3sQYXn6xsxPm
	HiOh9raPGthjiNISFRH4QPgOTkZcK2LD2RDFZ8GT8tH7zYGoDbzVh48AG+1RY73k
	KPFTWzTkCXC3jggs9BvmHVhPGsxwp5YLCzo4Ho6f5kzTeCljhYhLOguc6O3wYtTz
	1e6z2AUt5OMIFCdYaH82A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702195386; x=1702281786; bh=GMzfRuXTuCfqf
	XxuEBxu13Ipz45Rfi5cs2KL7JIR5Eg=; b=sXSg/dDMkwBLZR/LLeyEUzl9xflkI
	LsvzepApi4PSkhTqxnRoomTWPjzDaWjTeQ5WIzwynCSbXx7+kdwtqrGXt8QyjT/a
	3SNRKMZZ0kCfmhpSnl2k5+/od9sUndZ1i8M5GwTVTgBheSrwjMb3fKnnVUhS79YJ
	LLFgvYfpJ9EMX+VM7/uI4jzoNh4iVlReHzwPGXYYqthQEsnjj2Qc7+nHvGx+lZ+2
	v3daZyKZgjlEceJP/JAqRifTjAmm3Y+rKxGNq+FJjyVCTaXHtFq1bncoajsU4FKH
	QwA0l69B5XPO2k5sPdMDsZCIlpCsFJOksIjnLy640dJXIU8gXSR0jvxsg==
X-ME-Sender: <xms:uXB1ZXw0fW3V5EOqBdF5twQGxGBULdNaA8IN8VbdbmrhHhgPIRtn-Q>
    <xme:uXB1ZfTcvE2iCHtRuqbwpn2F77_KEntYKCTlIEBOc-pYQaQOBNGMBxTO3H3_8ucWU
    H5X5YVVf7W9wkuHwgI>
X-ME-Received: <xmr:uXB1ZRWkPQjTMzjakgmQaun7oVfPFrAr8ICxFdU5d7_dzB2mfVo55GdyBCW_7SBEFZSWa5uzpm--yrkhXoj4Ne20DkjnfqmLk6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghk
    rghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeekgefffedttedtlefhteduvdeuhfetleekkedu
    gfegudelueevhfevjefgkeehueenucffohhmrghinheprghmugdrtghomhdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:uXB1ZRgn6aE--U9j3-niV6gmn1cEA2tfIgjHhHphNkpiKsHoSe0f-w>
    <xmx:uXB1ZZD5yH-xkiU1eQk6gcgjsKW2VzNJRs_lnYkzTfcKezVg4ONQSQ>
    <xmx:uXB1ZaI-cGpebWtgf9oaeZb1Hr4peLLdbTa8uDs67OdLLmlSLxK2MQ>
    <xmx:unB1ZTCMp8fMW5YCPd-IJtOwFg4d4LIYPZP06IapVUzNIMPQJjjL2A>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Dec 2023 03:03:02 -0500 (EST)
Date: Sun, 10 Dec 2023 17:02:59 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
	LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
	bagasdotme@gmail.com,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Message-ID: <20231210080259.GA7823@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Mario Limonciello <mario.limonciello@amd.com>,
	a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
	LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
	bagasdotme@gmail.com,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
 <20231107121756.GA168964@workstation.local>
 <318cc8da-f8d2-4307-866e-8c302dacf094@amd.com>
 <20231108051638.GA194133@workstation.local>
 <20231128052429.GA25379@workstation.local>
 <80dbe1de-c71c-4556-817d-3f06e67f38ba@amd.com>
 <20231203122935.GA5986@workstation.local>
 <bbf24b56-cc54-4993-b048-eca5b9fd30ca@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf24b56-cc54-4993-b048-eca5b9fd30ca@amd.com>

Hi Mario,

On Tue, Nov 28, 2023 at 12:09:41AM -0600, Mario Limonciello wrote:
> Can you check FCH::PM::S5_RESET_STATUS on next boot after failure has
> occurred?  It is available at MMIO FED80300 or through indirect IO access at
> 0xC0.
> 
> If MMIO doesn't work, double check FCH::PM_ISACONTROL bit 1 (described on
> page 296) to confirm if your system enables it.
> 
> The meanings of the different bits can be found in a recent PPR:
> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/55901_B1_pub_053.zip
> 
> Indirect IO is described on PDF page 294.
> 
> This will at least give us a hint what's going on in this case.

I attempt to check the above. As a result, the value of offset
::S5_RESET_STATUS is 0x00080800 every time after the unexpected reboot.
(both cases of lspci and 1394 OHCI driver). The 'mmioen' bit of
::ISACONTROL offset is always enabled.

According to the document, the bit 20 of ::S5_RESET_STATUS expresses
'do_k8_full_reset' to mean that the system reboot was caused by
'CF9 = 0x0E'. But I have no idea about it...

For the attempt, I found a patch to i2c-piix4[1] and applied it with
slight fix, like:

```
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 809fbd014cd6..11c1ba3afa76 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -99,7 +99,9 @@
 #define SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ      3
 
 #define SB800_PIIX4_FCH_PM_ADDR                        0xFED80300
-#define SB800_PIIX4_FCH_PM_SIZE                        8
+#define SB800_PIIX4_FCH_PM_SIZE                        0x100
+#define SB800_PIIX4_FCH_PM_OFFSET_ISACONTROL           0x04
+#define SB800_PIIX4_FCH_PM_OFFSET_S5_RESET_STATUS      0xc0
 
 /* insmod parameters */
 
@@ -200,6 +202,9 @@ static int piix4_sb800_region_request(struct device *dev,
 
                mmio_cfg->addr = addr;
 
+               dev_info(dev, "ISACONTROL = 0x%08x", ioread32(addr + SB800_PIIX4_FCH_PM_OFFSET_ISACONTROL));
+               dev_info(dev, "S5_RESET_STATUS = 0x%08x", ioread32(addr + SB800_PIIX4_FCH_PM_OFFSET_S5_RESET_STATUS));
+
                return 0;
        }
``` 

> On 12/3/2023 06:29, Takashi Sakamoto wrote:
> > In lspci case, I can work with debugger and figure out that 'pread(2)' to
> > file descriptor for 'config' node in sysfs causes the unexpected system
> > reboot. Additionally I can regenerate it by hexdump(1) to the node:
> 
> OK - is this by chance related to access to PCI extended config space
> failing for this device then?  If you read just the first 256 bytes it's ok,
> but beyond that it fails?
 
I can regenerate unexpected system reboot even if readling from the node
enough shorter than 256 bytes. This time I use dd(1) for the purpose since
hexdump uses stream I/O API (reads 4096 bytes once).

> If so, can you please try to reproduce using this series from Bjorn applied:
> https://lore.kernel.org/r/20231121183643.249006-1-helgaas@kernel.org
> 
> And then add this to kernel command line:
> efi=debug "dyndbg=file arch/x86/pci/* +p"
>
> Capture the dmesg and share it.

I try the series by backport way, but it takes a bit time.


[1] https://lore.kernel.org/lkml/20230407203720.18184-1-yazen.ghannam@amd.com/T/

Thanks a lot

Takashi Sakamoto

