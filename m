Return-Path: <linux-pci+bounces-15698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807AC9B78B6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 11:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AF31F2345E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44BE1991C9;
	Thu, 31 Oct 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VN6hHEP3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820A19994A;
	Thu, 31 Oct 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370876; cv=none; b=sagRHIKSepmQ0ksJyTHuOTIOPyKnt6u32P/nmSQE71f/sBiDKZSWtV/njHEizf/jdAIvmguObooChn/Up812nBYGXbl5lU32pzY7pQzNy2M3kHWpC8EMTDgeS7ZCk7AQvOOoQ6AaXjvBpKw1BTKu1ZxRBhbg99HjWi/rPmqTq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370876; c=relaxed/simple;
	bh=TPbtUoJ+jGDTtJ0ySfxGn2crD4a9xAZ2hYxDO2co/Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQBFrb8c6Lz4URKjBMajecVWzcPIl/qrE5rwDkl0FiHFcE+7C/QGdyJtHawt8ZerARR57irffNBA0ta55VIXHp48eOzlxB7MORd4z3KF+MJgPZkUFbj/48vXkpAsvxw/4luK6rmkPrz0hAh1oL6PqwAPr39mCPcPcXLrRoCoQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VN6hHEP3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 12D0740E0219;
	Thu, 31 Oct 2024 10:34:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9H39GjSMgIyd; Thu, 31 Oct 2024 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730370867; bh=L+YfhXYMp9fc+q1eUkGrYH2j5uqrfhIaFjnfYZBfX8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VN6hHEP3RqRkVpvGO7kZl0b/W75I3QEmvBPAKGq1DMQYIKriDw24cQf8h87mcUyxq
	 ZxTdF38JplhZI48OBNcmCupfl+UEzKUn4wtXavDLvCFliGkyRWr54Nj/t2qNVHXCiE
	 jpO4PRKzIrbXfPRHWQLPOjcsZzX649mGv+wjKGA3pqGpnebZpLEgXhTDGgPhzwPRu9
	 PxvKcHknCzeUrT/eCKJ1RRFWKB24tWq06oMsYPDPoS9xb7Uo49mqZqV0IAc/Fd44jh
	 JihqF1cRwE1+IGWMApO0wVdc80FCY5CIKasgmvzaEFF4ZAQuK0ECYZ24McYHfccMzw
	 5oMbqYp3FlXzJHPGnxoEuOp+DgqYEapS+ihxdvB2I7f9iQOrFQtIL/2QJ7SOGAGLfi
	 vGad4GR6y5kO0Qmwd27cwKaigOHNtvjoCurpy93UOrLnvBx+EZ7FQYtKNDbiOv6LKu
	 /mhCTJcB9NfvBWbuq37VKGPPRivPcvsbg7kT0BlHlyP5thc25DxBqIH7XRm+gr6eZU
	 DgOX8MRc8ud2qxP6G/UmjbKzCAPGWBNcWA/JyJqRFIY2BLnW+2Hto/lhSs8IYqwWpI
	 Qc4icAwGb9yMgsq3ozBWvz/s4cQuL2URvj9BHj8v3mHalQJF/hr1/MpOWVU0KNRWmp
	 8U6ialZU3K4qvyODeGbfxU+I=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE8F940E015F;
	Thu, 31 Oct 2024 10:34:02 +0000 (UTC)
Date: Thu, 31 Oct 2024 11:34:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"avadhut.naik@amd.com" <avadhut.naik@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
	"richard.gong@amd.com" <richard.gong@amd.com>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"clemens@ladisch.de" <clemens@ladisch.de>,
	"hdegoede@redhat.com" <hdegoede@redhat.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
	"carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH] x86/cpufeature: Document cpu_feature_enabled() as the
 default to use
Message-ID: <20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-4-yazen.ghannam@amd.com>
 <20241025155830.GQZxvAJkJnfLfNpSRx@fat_crate.local>
 <20241029143928.GA1011322@yaz-khff2.amd.com>
 <20241029150847.GLZyD6f-Hk6pRTEt2c@fat_crate.local>
 <SJ1PR11MB6083AA7B2E28F2DA24E4B456FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241030142138.GA1304646@yaz-khff2.amd.com>
 <c2894e47-f902-4603-84e7-a9aca545b18c@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2894e47-f902-4603-84e7-a9aca545b18c@intel.com>

From: "Borislav Petkov (AMD)" <bp@alien8.de>

cpu_feature_enabled() should be used in most cases when CPU feature
support needs to be tested in code. Document that.

Reported-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeature.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 0b9611da6c53..de1ad09fe8d7 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -132,11 +132,12 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	 x86_this_cpu_test_bit(bit, cpu_info.x86_capability))
 
 /*
- * This macro is for detection of features which need kernel
- * infrastructure to be used.  It may *not* directly test the CPU
- * itself.  Use the cpu_has() family if you want true runtime
- * testing of CPU features, like in hypervisor code where you are
- * supporting a possible guest feature where host support for it
+ * This is the default CPU features testing macro to use in code.
+ *
+ * It is for detection of features which need kernel infrastructure to be
+ * used.  It may *not* directly test the CPU itself.  Use the cpu_has() family
+ * if you want true runtime testing of CPU features, like in hypervisor code
+ * where you are supporting a possible guest feature where host support for it
  * is not relevant.
  */
 #define cpu_feature_enabled(bit)	\
@@ -161,13 +162,6 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
 /*
- * Static testing of CPU features. Used the same as boot_cpu_has(). It
- * statically patches the target code for additional performance. Use
- * static_cpu_has() only in fast paths, where every cycle counts. Which
- * means that the boot_cpu_has() variant is already fast enough for the
- * majority of cases and you should stick to using it as it is generally
- * only two instructions: a RIP-relative MOV and a TEST.
- *
  * Do not use an "m" constraint for [cap_byte] here: gcc doesn't know
  * that this is only used on a fallback path and will sometimes cause
  * it to manifest the address of boot_cpu_data in a register, fouling
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

