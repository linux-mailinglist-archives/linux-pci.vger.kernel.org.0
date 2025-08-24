Return-Path: <linux-pci+bounces-34630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73500B33156
	for <lists+linux-pci@lfdr.de>; Sun, 24 Aug 2025 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788261B25BA5
	for <lists+linux-pci@lfdr.de>; Sun, 24 Aug 2025 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00B1EF363;
	Sun, 24 Aug 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bGfCh8xd"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AB463CF;
	Sun, 24 Aug 2025 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051592; cv=none; b=mrw5kG/AdW1abJWS+PyjJueaFh4MNu1CguiNlzFjF/R60j7qkH/A7WGTBiWD6rNZak6JwJxSQBbMzaw3+bOmfuVoxGYyUJUixJMQ61Y6p2y3LVkhhWCZ8N6Q4Gg3CDzF2cLa4nNI2VIsFvPhszaoN/M0By5B+CLHrpC6GE4DjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051592; c=relaxed/simple;
	bh=K1fzHwMAmQ/SyfeKkyh32Aghmhd99FJr4xB8RhJzdiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLWfUxQGHiYeMekjA4D2cy56NgrnppDwsr+LXc2QuOStvz2OuF8qoLdcXXO1eryUKl+Kg7hylWPh/E7ukPWOq2GliSf1/lO+XtD/H7Bz0XV/uJWreTvC2EbGtRRCyHp4DoA2ahMAG2X5Z6nNUaRVbrg0Xq0O4MZkV7Q7UeGpnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bGfCh8xd; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=dxFqYL2xUFVSgnNZLKy6IdULs4Ge7699nD88Uwq2FlY=;
	b=bGfCh8xd1nLCCzVFuUNfI5TdhmfFOK1D/1eQtQ4oUTIE6neTjMgtfJ1CXSmUsi
	1/tJJu4PRxzBuAAnGMNcQgwJ6+FdAREnRkxEF/uV2d+VkOHVJX0jxMfp+hMQvPH4
	wiU3HzTzj7dV22M6sa10OemEdH+Bd6HPacGPg6whq64Uc=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnli1GOKto2Nu3AQ--.64521S2;
	Mon, 25 Aug 2025 00:05:27 +0800 (CST)
Message-ID: <155f9f4f-45e4-45ea-85c2-de67115bd12c@163.com>
Date: Mon, 25 Aug 2025 00:05:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] PCI: Replace short msleep() calls with more
 precise delay functions
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250822164638.GA687302@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250822164638.GA687302@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgCnli1GOKto2Nu3AQ--.64521S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw43tF1fZF1xKr1rXr1rtFb_yoW5uw4rpF
	W5Gr1jyF4UJay5Aw1Iya1rCFyrWasayFWFkF48G3s3Zas8Zry29F4F9FW5Wr1DXrZ7X34a
	qa15A3yUWFWYvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UjFAXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwGzo2irNCpciQAAsC



On 2025/8/23 00:46, Bjorn Helgaas wrote:
> On Fri, Aug 22, 2025 at 11:59:01PM +0800, Hans Zhang wrote:
>> This series replaces short msleep() calls (less than 20ms) with more
>> precise delay functions (fsleep() and usleep_range()) throughout the
>> PCI subsystem.
>>
>> The msleep() function with small values can sleep longer than intended
>> due to timer granularity, which can cause unnecessary delays in PCI
>> operations such as link status checking, reset handling, and hotplug
>> operations.
>>
>> These changes:
>> - Use fsleep() for delays that require precise timing (1-2ms).
>> - Use usleep_range() for delays that can benefit from a small range.
>> - Add #defines for all delay values with references to PCIe specifications.
>> - Update comments to reference the latest PCIe r7.0 specification.
>>
>> This improves the responsiveness of PCI operations while maintaining
>> compliance with PCIe specifications.
> 

Dear Bjron,

Thank you very much for your reply.


> I would split this a little differently:
> 
>    - Add #defines for values from PCIe base spec.  Make the #define
>      value match the spec value.  If there's adjustment, e.g.,

Ok. For patch 0001, I will modify it again.

>      doubling, do it at the sleep site.  Adjustment like this seems a
>      little paranoid since the spec should already have some margin
>      built into it.

Can I understand that it's enough to just use fsleep(1000) here?

patch 0001 I intend to modify it as follows:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..fb4aff520f64 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4963,11 +4963,8 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
         ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
         pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);

-       /*
-        * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
-        * this to 2ms to ensure that we meet the minimum requirement.
-        */
-       msleep(2);
+       /* Wait for the reset to take effect */
+       fsleep(PCI_T_RST_SEC_BUS_DELAY_US);

         ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
         pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..9d38ef26c6a9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -60,6 +60,9 @@ struct pcie_tlp_log;
  #define PCIE_LINK_WAIT_MAX_RETRIES     10
  #define PCIE_LINK_WAIT_SLEEP_MS                90

+/* PCIe r7.0, sec 7.5.1.3.13, requires minimum Trst of 1ms */
+#define PCI_T_RST_SEC_BUS_DELAY_US     1000
+
  /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
  #define PCIE_MSG_TYPE_R_RC     0
  #define PCIE_MSG_TYPE_R_ADDR   1



> 
>    - Change to fsleep() (or usleep_range()) in separate patch.  There
>      might be discussion about these changes, but the #defines are
>      desirable regardless.
> 
> I'm personally dubious about the places you used usleep_range().
> These are low-frequency paths (rcar PHY ready, brcmstb link up,
> hotplug command completion, DPC recover) that don't seem critical.  I
> think they're all using made-up delays that don't come from any spec
> or hardware requirement anyway.  I think it's hard to make an argument
> for precision here.

My initial understanding was the same. There was no need for such 
precision here. Then msleep will be retained, but only modified to #defines?

If you think it's unnecessary, I will discard the remaining patches.

Best regards,
Hans



