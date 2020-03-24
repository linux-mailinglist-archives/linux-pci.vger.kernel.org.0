Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90635191992
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 19:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgCXS6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 14:58:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbgCXS6p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 14:58:45 -0400
Received: from zn.tnic (p200300EC2F0BC80080B0BF5C4664F3C7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:c800:80b0:bf5c:4664:f3c7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A7121EC0CDC;
        Tue, 24 Mar 2020 19:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585076322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lIsYy50HXEV0jz9brVxw6K/8V+POkTYJ1qZEO3jtQOg=;
        b=UbGUgZ69w4Pss5KZcP0C5ESSPwJnCZ+xLrK8REFRMm8MOCwnwgNDcPNNugDTJ+7KIwZSFC
        e/kJWtYxyIsXtyDUQzsUBRadkW8G4F6hrSbBvbtrMmiWK9xxBgpLZNe84h3kMcq6J81FTB
        cG1Lotv4gFJ5JLaB6VJMHXCySgkcsMI=
Date:   Tue, 24 Mar 2020 19:58:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 23/22] x86/smpboot: Remove the last ICPU() macro
Message-ID: <20200324185836.GI22931@zn.tnic>
References: <20200320131345.635023594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200320131345.635023594@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

---
From: Borislav Petkov <bp@suse.de>

Now all is using the shiny new macros.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/smpboot.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..3b9bf8c7e29d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1849,24 +1849,25 @@ static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
-#define ICPU(model) \
-	{X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF, 0}
+#define X86_MATCH(model)					\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
+		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
 
 static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
-	ICPU(INTEL_FAM6_XEON_PHI_KNL),
-	ICPU(INTEL_FAM6_XEON_PHI_KNM),
+	X86_MATCH(XEON_PHI_KNL),
+	X86_MATCH(XEON_PHI_KNM),
 	{}
 };
 
 static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
-	ICPU(INTEL_FAM6_SKYLAKE_X),
+	X86_MATCH(SKYLAKE_X),
 	{}
 };
 
 static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT_D),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS),
+	X86_MATCH(ATOM_GOLDMONT),
+	X86_MATCH(ATOM_GOLDMONT_D),
+	X86_MATCH(ATOM_GOLDMONT_PLUS),
 	{}
 };
 
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
