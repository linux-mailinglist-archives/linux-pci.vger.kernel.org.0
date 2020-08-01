Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F57C23522A
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgHAMZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgHAMYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:37 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3826BC06174A;
        Sat,  1 Aug 2020 05:24:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bs17so5368392edb.1;
        Sat, 01 Aug 2020 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mTab8JNvsgo4CL+J2E65GCxL4zVDcvJICP1+e2MGiww=;
        b=MxXS7aXGg49OI8aq1o2JxQSacx3GEkx7XRc4h3ldURK6zBJgpz5BCs4TCQi9vzW8bw
         6N5rmJ/Bc2EsNZmNEy95m4VrSdD6S36XHIE0bXDvbmHdvv8Ihd/DN3YqOot8+XNsBn4K
         uH6Ip0XLj/CLkS7OQbIMeU5cG1JmDbAF6R4dkjrmVllWjiJc6lq/K7WJN3y20CFnB+Zq
         Veh4WXw6cFj5wfDJzSErjSaJ/GQ1p/YmseYNttpG96RLDnixkmg9o75N4xiBxD0qqPsJ
         1iL8Qj7buxqLPP29VEWOUOsDSz4OPW5lGkFWyKdBy9bfKl3Yd4OWQ3uoiFlz2n2kpCGD
         NGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mTab8JNvsgo4CL+J2E65GCxL4zVDcvJICP1+e2MGiww=;
        b=pa8PyqiRXCleEs8MJbgKvUwLyhtbQQKu/3LxyfJE9G9tvCw/rM1DitlyNwNeLnHt/q
         mmjTUBnfiX5t3aWU6JVhZ03SdIITbjognEdB0rCuU/FsMt+ICDIx71iz2SLMKwYgTzqG
         kij8iQ4YfXDa7vKTxTANaUB1UrcdFtKuqPtFPIQ3NuBCRWj9mMVLS9NXH7+V7WFQQ0i8
         mRFm5ViuF3ydIDiD5m9asVBX4TwZdqLLg90Eo+2Cbb3PuaffIRRkK7RYiWy1JAZa5iPP
         ZZOdBvCHUMCzn7YVxpsH5iedrviT+WwT5cPQvNqM8BpVM9C7twVKJN6ndStIcxdddgi7
         kYdA==
X-Gm-Message-State: AOAM533934lHCn1H2Qf5XdkoTyeyge9gkiIKcjj5cb0YC18dmILmUg9y
        oTOQh/LUlPLi37H6hXaYj8Q=
X-Google-Smtp-Source: ABdhPJyNuqCc/8r6/A/7Q7T/LnVDBWUQ9SzPEt/TNIqjoVA3EMIMDnSI53A+QOmplMa8tW5cITLjzA==
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr7805559eds.212.1596284675988;
        Sat, 01 Aug 2020 05:24:35 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:35 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: [RFC PATCH 09/17] drm/i915/vga: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:38 +0200
Message-Id: <20200801112446.149549-10-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_vga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
index be333699c515..6f9406699c9d 100644
--- a/drivers/gpu/drm/i915/display/intel_vga.c
+++ b/drivers/gpu/drm/i915/display/intel_vga.c
@@ -99,7 +99,8 @@ intel_vga_set_state(struct drm_i915_private *i915, bool enable_decode)
 	unsigned int reg = INTEL_GEN(i915) >= 6 ? SNB_GMCH_CTRL : INTEL_GMCH_CTRL;
 	u16 gmch_ctrl;
 
-	if (pci_read_config_word(i915->bridge_dev, reg, &gmch_ctrl)) {
+	pci_read_config_word(i915->bridge_dev, reg, &gmch_ctrl);
+	if (gmch_ctrl == (u16)~0) {
 		drm_err(&i915->drm, "failed to read control word\n");
 		return -EIO;
 	}
-- 
2.18.4

