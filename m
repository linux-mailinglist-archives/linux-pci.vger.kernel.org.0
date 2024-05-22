Return-Path: <linux-pci+bounces-7755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D78CC4BC
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35AB1F22BFE
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B556444;
	Wed, 22 May 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ahHcFbLJ";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="M2ccUJ5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5882869B
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394478; cv=none; b=hiIeTHbjMPDd0jeYBd1TH93y4Pt4GNxTQGnSgkdUX3dQS+HKkh0LwG/nYVAG04k+OKxWD/vRoYTNLRmA3NZdcnyq0psCGl5M7UxjjYqJ+ISlxZwaGmQhDwo7wJnad2+WMvnKyqjX//RzC4BeKCKrFYkbpswDRn0CLNDiTc8kTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394478; c=relaxed/simple;
	bh=oFrpeI8iuiwLywqkzLVa7EnTh1eXLHZXFkaTZFMAwqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FSwSGSgNV4b17TCxVWIGvJ+PuuZcEzIDI9Z4lStThXwXAw/FOabo7clcxze+yXjP69j/zcC86XSGXE9dgWASL9V45/b046/1UOrl6/fAwBBQQbSE86D1SUgR0yK4v7CJV2j4UwuwXLliqCCKhSJUlwkSIMcvvOgxxN6kUYqaIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=ahHcFbLJ; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=M2ccUJ5O; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com F3170C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716394041; bh=NnEmWc8vyujFXDLcuMZKSPG3QOonBGAsJyQ2L4f0ceI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ahHcFbLJpsLfqPjnYuba375DaWrPTNX6xLzBukkSy/Ou3WLL74nk24bbKixiofjwJ
	 A7qr5+BlMEJKwcFIbfMgTAh5/Ke+2jTeEAMTUP1qdiJLev0flZL0x95/Dscjw5YBPn
	 lSQaL1+RhfH46jPgqCbTvST7LQLvWdWlFPbFLdvUnxlMw5Kitj9vEr1RWBCgbloYVa
	 DZyJaFhw6fHPjtDZVkwQ89l9TtblfrofRqdwsweUL7GdJubeaM6odGIcv0i0Lt/+9C
	 7do3/+QGAuZF3fQkgQHLyYfMHce7w6ttBnG/ZMwm34NbiK6bIm8YxN/LI+FAjHnwNv
	 8sEqXjiRbVsFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716394041; bh=NnEmWc8vyujFXDLcuMZKSPG3QOonBGAsJyQ2L4f0ceI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=M2ccUJ5OT11AB252oBSctYWoJmL4weiElkD3XHp8wZpkMacp1N+DZ2tb8L51RsG4+
	 GKbr8Z2BfMseRHHqwazQfuLUf6HufPZnA3uK7rBb5Md05GCYVbrmOlft1Evatlcv9x
	 BpsKFRgq4Vi27ng1ez3D6G7rU4pV9KxqmO8mJ9Fi8hvhQ0YJko/KdWzVHopguEAMug
	 nZb6SAZvqo0KiFKnuVm8aF/GJGqfY9neC+NEEqKybZU6brFl+I16P3anzf634t8oBL
	 1lDrWjYDse3ta9OWMx2buMDVOCo/ir2esbPalcU0I0WkWAJ77VI++5dktEpthpCCdr
	 C/m8doG0FYEdQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils 0/6] pcilmr: Improve grading of the margining results
Date: Wed, 22 May 2024 19:06:28 +0300
Message-ID: <20240522160634.29831-1-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Original version of the pcilmr utility used values from the Table 8-11 of
the PCIe Base Spec Rev 5.0 to evaluate lanes. But it seems that these
values relate only to the margining equipment and are not relevant to
evaluating the quality of connections.

Patch set improves grading from two sides:
* The PCIe Base Spec Rev 5.0 sets the minimum values for the eye in the
  section 8.4.2. Change default grading values in the utility according to
  this section. Keep in mind that the Spec uses full eye width and height
  terms and that reference values depend on the current Link speed;
* Manufacturers can provide criteria for their devices that
  differ from the standard ones. Usually this information falls under the
  NDA, so add an option to the utility that will allow the user to set
  necessary criteria for evaluating the quality of lanes.

At the same time, fix the known limitations associated with arguments
parsing.

With the new changes made, the logic responsible for arguments parsing has
become too large, so put it in a separate file.

Nikita Proshkin (6):
  pcilmr: Ensure that utility can accept either Downstream or Upstream
    link port
  pcilmr: Move most of pcilmr arguments parsing logic to the separate
    file
  pcilmr: Add new grading option
  pcilmr: Add option to configure margining dwell time
  pcilmr: Apply grading quirk for Ice Lake RC ports
  pcilmr: Update usage and man: new arguments format and grading

 Makefile             |   2 +-
 lmr/lmr.h            | 103 +++++++++----
 lmr/margin.c         |  72 ++++-----
 lmr/margin_args.c    | 302 ++++++++++++++++++++++++++++++++++++
 lmr/margin_hw.c      |  57 ++++++-
 lmr/margin_log.c     |  23 ++-
 lmr/margin_results.c | 322 +++++++++++++++++++++++++--------------
 pcilmr.c             | 353 ++++++-------------------------------------
 pcilmr.man           | 138 +++++++++++++----
 9 files changed, 841 insertions(+), 531 deletions(-)
 create mode 100644 lmr/margin_args.c

-- 
2.34.1


