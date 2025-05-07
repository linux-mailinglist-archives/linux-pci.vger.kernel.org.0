Return-Path: <linux-pci+bounces-27398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D6AAEE6F
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 00:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA831BC7CAC
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F22290DAB;
	Wed,  7 May 2025 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK+8Ex8K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C561DD877;
	Wed,  7 May 2025 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655498; cv=none; b=E8jjexzpqZ0P66r770nBomryeHbOjnB0qnAk5SE5g1UHrAuZOKTwToBxwBRZGhOk5OU0fq+Bek6+vnhajsXCwJ098yRBgAPbwPtf/v7OWpnZ8LkzUx9yknmBWhP4QqudHsbXmGqW7+EUGUyQxm6g74xLTnVllq0mWw45O+q/o0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655498; c=relaxed/simple;
	bh=+x7Cr9dClfkALRI1rM+EMxxZ9XnY/VO8mCUEw6mL6mE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WzhhHrZVIXrnEvYcQrwf4BYU+qnbCUveWoYeluheCsEVnJMnwREwL2gX2Cqof+WCDWKp5spUfuFFCWL93pj4RJUJNg9OyjAEWPDBa8zSZ9PWlEZGe7Bm6pfl3tzcGQ9kOIYB9fE6ZoKfaJzvaxdqKmJC73ZAK/p/gmQBFgRwVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK+8Ex8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD0DC4CEE2;
	Wed,  7 May 2025 22:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746655497;
	bh=+x7Cr9dClfkALRI1rM+EMxxZ9XnY/VO8mCUEw6mL6mE=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=IK+8Ex8Kkjw5Jjn6ssw2RBxqj1nNkoiBG2C0qcLSP+H6hDHPVmMDQjqGPimLCvLun
	 E7jvwJ1pD4+GOCiZz2zJ7kPsET0q6Rfzhihv+3kLYuoUsbbsHPA9MDAG6jh7IhqWrT
	 /LpkDtksS8eRL59zCrCbPUYnUCaUDndT61CmD0NDFNLyJg+Wrl1O0e5uaEvKf+kVoo
	 dAFvoUVntrlPQIX800F8K+52QsOewlVTVF5oOEE3XZHLCSJV1JOlLvMKFk8UgxcprO
	 DFIzA9j2T7j4/Quh51Egkdt56kWv+JwMhN8maCnfIG3eJRC93uwcwIPnV90I3lAdfv
	 X+NTDVuxiQwWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 265D8CE0D1D; Wed,  7 May 2025 15:04:57 -0700 (PDT)
Date: Wed, 7 May 2025 15:04:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
	linux-next@vger.kernel.org
Subject: [PATCH] PCI/bwctrl: Remove unused pcie_bwctrl_lbms_rwsem
Message-ID: <3840f086-91cf-4fec-8004-b272a21d86cf@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

PCI/bwctrl: Remove unused pcie_bwctrl_lbms_rwsem

Builds with CONFIG_PREEMPT_RT=y get the following build error:

drivers/pci/pcie/bwctrl.c:56:22: error: ‘pcie_bwctrl_lbms_rwsem’ defined but not used [-Werror=unused-variable]

Therefore, remove this unused variable.  Perhaps this should be folded
into the commit shown below.

Fixes: 0238f352a63a ("PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index fdafa20e4587d..841ab8725aff7 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -53,7 +53,6 @@ struct pcie_bwctrl_data {
  * (using just one rwsem triggers "possible recursive locking detected"
  * warning).
  */
-static DECLARE_RWSEM(pcie_bwctrl_lbms_rwsem);
 static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
 static bool pcie_valid_speed(enum pci_bus_speed speed)

