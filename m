Return-Path: <linux-pci+bounces-14202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2E998D5B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F0C1F21BD7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B71CDFD7;
	Thu, 10 Oct 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBfZ7uX+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B91CDA2D;
	Thu, 10 Oct 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577679; cv=none; b=uEbB87FFn1g7tpGrJ6uh0t2+j4dGOtXcjh7ATbThDoYA39+mVbyQfHpGogYV++OMu0X96LiTQxIEkm/SPgs5aSSDSfwjlBEO+Kz9zYIsJNGyJIrVB5M4Uix5QaatP96+cM4Zf161djMAM9MjwjKfflwighBXXdskLQZQXd5NIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577679; c=relaxed/simple;
	bh=pAybqgmIwmNbjIqIXpZlFut4c805d6kX1GVVhSSpf4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RuHGWbDHb87Ujet5DVCf8KbsPoKLFtzJZmsJD//6ixPSG/L0SffletITfJbJTn/uFNvUl5EZ0M0qVjo+30TSmbRpqdVxYKgFMy4eU0snL8eCxj330DvBCrrM65etvp72gbaPEQwNRDinFmmMnifz4pB6HLoZDhAjR1c7UR3+54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBfZ7uX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572A8C4CEC5;
	Thu, 10 Oct 2024 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577678;
	bh=pAybqgmIwmNbjIqIXpZlFut4c805d6kX1GVVhSSpf4E=;
	h=From:Subject:Date:To:Cc:From;
	b=jBfZ7uX+rcc6o5/ZXq3r82ktchz1KruUBipM0Bt1cyGrhWMVvmsNZiWSF252Q6CQt
	 UOy9+fcU2zh1JfVpHygVieVMU04aO4PO05d0F95PYOONCEdIXt6SS6zj78PLzGUsa6
	 l7KDGQqeGtrUjuUmBbVUPzVcp2bJjObcM31QvVjscGWIDXTgnkpG4WxvafZlt3eW1J
	 PUAF4WBFay6uC4+oFrvtVtuo3g/yQ7gNAcu4CPdVhCNXZhY6krZnhnrlBzc3C3rdBP
	 FOVQev0+vuXpd9cHSk6IixbWFVNZTzBkp62M5jT89rG23QaMvUxVrIQ+MHBB08AKrW
	 HJUPahZtylCQA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/7] of: Constify DT structs
Date: Thu, 10 Oct 2024 11:27:13 -0500
Message-Id: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEACGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MD3ZQS3eT8vOISXfPk1NQ0c+OUNCPLZCWg8oKi1LTMCrBR0bG1tQC
 6u1wZWgAAAA==
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

This series constifies many usages of DT structs in the DT core code. 
Many uses of struct device_node where the node refcount is not 
changed can be const. Most uses of struct property can also be const.

The first 2 patches are dependencies. The functions called by the 
DT core where the fwnode_handle needs to be const to make the containing 
device_node const.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (7):
      PCI: Constify pci_register_io_range() fwnode_handle
      logic_pio: Constify fwnode_handle
      of: Constify struct device_node function arguments
      of: Constify struct property pointers
      of: Constify of_changeset_entry function arguments
      of: Constify safe_name() kobject arg
      of/address: Constify of_busses[] array and pointers

 drivers/of/address.c       | 22 +++++++++++-----------
 drivers/of/base.c          | 20 ++++++++++----------
 drivers/of/cpu.c           |  2 +-
 drivers/of/dynamic.c       |  4 ++--
 drivers/of/irq.c           |  4 ++--
 drivers/of/kobj.c          |  8 ++++----
 drivers/of/of_private.h    | 12 ++++++------
 drivers/of/overlay.c       | 19 ++++++++++---------
 drivers/of/property.c      | 10 +++++-----
 drivers/of/resolver.c      | 12 ++++++------
 drivers/pci/pci.c          |  2 +-
 include/linux/logic_pio.h  |  6 +++---
 include/linux/of.h         | 28 ++++++++++++++--------------
 include/linux/of_address.h |  6 +++---
 include/linux/of_irq.h     |  4 ++--
 include/linux/pci.h        |  2 +-
 lib/logic_pio.c            |  4 ++--
 17 files changed, 83 insertions(+), 82 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241010-dt-const-7ceef73df29c

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


