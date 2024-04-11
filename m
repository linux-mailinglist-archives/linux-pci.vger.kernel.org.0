Return-Path: <linux-pci+bounces-6133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D132A8A1AFF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 19:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F31B1F27B15
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE5C201999;
	Thu, 11 Apr 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="N+JmWxX8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732DC1FFC5C;
	Thu, 11 Apr 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850214; cv=none; b=UUPtjEslIPE4H0bQih5T1hJ8h+2RTxnVFlFAUlYeMoX4Hc9D9XLeHtPu4qJdE4COXlgVcohAUExXqWWq+zs7GKNfLqKzfYWo9VdM1fnIOzyOq3x9PdLpl1Rk8J+RmHpKhxhuOtUrr1XGRA8ps3OZKGYuPDBSaL2JlVpOYU132+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850214; c=relaxed/simple;
	bh=G/uDq8R2cEJGETysdgyw+/FbbvpRatIhc4DdkmlZI7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQ6I8/gSc3L2JqJPDzOUSPO2tvZ2+KaHCiytmffbjlLY7p+m5vLA4kkf/CCAMEdh1ZwGIDt/zn+NNbQ0E5zxk7bofBRQMdiAvdDriS2SX3cV2ys6XOwca+0VTFccLwQxbmikR9ipiRuUC095udtHYjNN7yhQf6ku3SEoxjj+ZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=N+JmWxX8; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712850207; x=1713455007; i=parker@finest.io;
	bh=Wmyh4+ECtBW0Jh/HVjgWQOVgBLp1r/1BdeWBCqXIMJU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=N+JmWxX8X2C7iukAkyyle1+I3fOz7RM7RDk0GDHH1HhP0zu4JLEFcd96sXkELpB+
	 LGM7jd0Py4pCpqzkTpJBwzgA9f6TXel4lA9P6+E/UYc4Xyjn2dLRirSBwaEhDkWmT
	 c9NlzfkZ8xvBwLiYXt8O2ksx54Efyft1Tg7ZH6Re4U2epCTeEN6wiUpEhQjdJKsPL
	 yA+aLj6vqvjlG8Tl1UBQpGjyF0ej4sSTpW77Jne7iFWmbgy24wnmsnnUqoQR1rCKe
	 Gw0X80eq9/TVFx9gCFn63ZCu00MrEzAvG/hj7k60UA2ZwmBeYOh9LpT9qH7HIB7rE
	 rhwueu2nxhw5l41jyw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LsBB3-1suW0J0tXL-00to1W; Thu, 11 Apr
 2024 17:30:04 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH 0/2] serial: exar: add Connect Tech serial cards to Exar driver
Date: Thu, 11 Apr 2024 11:29:25 -0400
Message-ID: <cover.1712846025.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xqtzeB7BoSjGN76zplJXS9B9wmmGlf1dciTVJVO/D8DMswVfxcC
 Jz8+JXKQu2GMLzZdvxrVG+dGGWoe5r6dmqzd1bx14wa+dKMu8noevmQx9rlyXprlTMdukSG
 yK1KHNe8K1OskvxzGad1doerz6uOFgiNwdm8wlIDIPXjtFGa8D60PJM7kJU4bK3YcfJRJbO
 LY0Vnmona40ZK0nlDWQ8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XfH5YioreMY=;q20CEaQ7J56knqbZMJLYmfWUUgK
 XmmlL0se7pW3gdsuAS3egnk7UTa8F/j+4dt/4tR5asMi+6zB/Jf1X1g82huV5o65LTh6dki74
 eIQpVRbePI17eH1RF6lgve0cXxMVNAqzMwkXOxsWEtxcTXygI7O+K2IWK+q/Wgg3HEZbr8SpH
 Z9jXS88vufPqjIw8K4//vG/gBYKqsl75/0cf5Pj6XEq8jHf8MAVo9kDnXAcWprNqvxLFFQVLW
 tYe0NfpjrSfFL7TSJRbn0vAd9VqiB+xoTkzS6W89M1MvkvOrlUWmx+s24uHwaH6NDEmxef8re
 ikMFZ3BIc5rlXC9nljVrPd8R2JcIg/qIagUHzKQwt2nvaN9mJ44W4XOi6F0hZSh/wlglDUNjo
 KbJLybG2nbd2YkqBWuZK5QphcJpEkjRdqIdZgvy6n0pJvXWPixXk9Y7ZtlhcLJYXWtxYOQI4B
 vsi+RMh4V+6LofVYOWcSeQGn1ROB6sq5Us9p+V7CBNkInVgGX3Ev85QbG8CLLYO8NKIR91W3M
 Y/sheKDNQLL6ndiVYV29qdM1o1g5mqsd/toh8eJSdxBKx1fpm3dAhxdkVWChmac+MBulMIT5B
 VxCiSeWOU/kbFOf6CQvjqqvUTrAFvPhIr0mYcDzotaoY+txoQspkd6ZS0Bv8uQI17Z5V6ZS7J
 TJivTsfZWQDFShp9oCjTQ02Z6s6SXB3Sd8YZyCwerftwdYOnKh8pQ6kwcoVPcC5XuIeVINfWn
 FPT6kNji1yLowUUeWUVAafL6tXJdZja6KDt8Ht/1Mq6DrXvnxi5oZE=

From: Parker Newman <pnewman@connecttech.com>

Hello,
These patches add proper support for most of Connect Tech's (CTI) Exar
based serial cards. Previously, only a subset of CTI's cards would work
with the Exar driver while the rest required the CTI out-of-tree driver.
These patches are intended to phase out the out-of-tree driver.

I am new to the mailing lists and contributing to the kernel so please
let me know if I have made any mistakes or if you have any feedback.

Thank you,

Parker Newman (2):
  serial: exar: add missing CTI/Exar PCI IDs to include/linux/pci_ids.h
  serial: exar: adding CTI PCI/PCIe serial port support to 8250_exar

 drivers/tty/serial/8250/8250_exar.c | 1092 +++++++++++++++++++++++++--
 include/linux/pci_ids.h             |  104 ++-
 2 files changed, 1094 insertions(+), 102 deletions(-)

=2D-
2.43.2


