Return-Path: <linux-pci+bounces-36070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22595B559D6
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 01:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452E41D6252F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA232848A2;
	Fri, 12 Sep 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A5EqVE9p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF925F7A5
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718596; cv=none; b=BTiaOY7dLuD1GAyGTzCgKq3YLvFl2Ccx04f/gSUbx/+HUKUeLtH+MLJMkDX3RaeBQtqopJs6+NP3UoivrO+xryepG5X9abGkCwHQyRrPtbCz/GbKq8ZQAuX3rSYTpYJAM7TTSx/yg13hcqdOSYeSvhx4CP3abZ470OxQ6gl2Xq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718596; c=relaxed/simple;
	bh=sXvBWDb9hTBPsLaRegbOtBiO673LvoBjYekcWqme0qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFt1tI1tY4tNiCjqjen7I0A1LNDc0lObLR0r5LKIITR31QAAQ47UEFY5+Zj1HJYjdvSNnxW9khvoBbG86R274Bi2CC6LskihYJK5/osrMxsFQOdQdE0kbjoHjr0eng6PlKZ/TBBoY0duIr6kFSu4X0Rrf7i4Oegb+wvvatTos3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A5EqVE9p; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2418535b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718594; x=1758323394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dwNY0wU9h+Jp/qHmj3QCzMa4YfF1MmR36mm3/7OnW8=;
        b=A5EqVE9pmugzFbDWRw9h5yEqB1aD+F0NpX/kb+FCZLiOR8ng8+zTLThkd6E99KifsL
         oGgKnE62y6iDS+uoxPXQTFMLKbajfOcFmT/qg6H3cIj349iifoNMkK+dVjdrx//e6/Wu
         gbsBm1UaHa3qcZuVb5w8WUXEYHhW+FpMGu0tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718594; x=1758323394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dwNY0wU9h+Jp/qHmj3QCzMa4YfF1MmR36mm3/7OnW8=;
        b=wW2gfOfkl7SfVuBFvTPQa+rXBSYNAdzOQpiBHiHg4f1vaD4NIbi5tLYM9P7xnjy21N
         2WPCLwdWsracacxSNlpBy9Jo3VCuXPwj79rjsVh/fpZY9N98d5taOlM+tLemIFljO8pZ
         wN587cBfiubzZ0gLITWYxp94I1qHQAuCO+0XyVZ+9pDzdFP3N0mm31L5Z2N7YreFbFSa
         D3oR6cU2/JddlIIQIsRS0KXRp0zGgz/Qp4eS+ow1Wc5uWMbwNtspaydpjAWFHS/0GbHS
         9sFXHs7mISgqB3sH201YpCcPj0+CuQ/hN4nnmov/bJW6/cGGJnnu/b/1fSgNSPdvRsGp
         MHzQ==
X-Gm-Message-State: AOJu0YxtkfNsWUo6DUs9A3HDjXmbQCM8FAuySflfRgPH+cEsOTkfNZdZ
	7Zj0YTTWwwF4Y5kgzg+j4ip7xAmJicTKYYs6T5P5LA5y8GA49Xl2oYhMB+RnXVGO2Q==
X-Gm-Gg: ASbGncux/Y0o4kH9+6ZQX4VjyFI0Eq5rpUGDCJzFxqm0KOw6XsLSOMi+NMCOYPAu8iM
	uiOq6ZPQ8sXjofp/i/4gLoM2x2tcfNkuuqKSp6U4pBg2e7M0/8BokeBIppSwzTQ0G8tZS7+FfED
	z37zkmkxtLHjM5l8EBt3UWmC4WkBK2BunDWuDTEYNWxpR+dg4OAyYtCONF7TlcpW9oS9wH/YKkv
	E+SyiCg3Wu7mGIN1bkIg8/hQADkr92CQ+5fDx/+w+4UigEeEiZjeRACO4eVA+w+tUD/ncNLhCQe
	WUM73Mc4rC0MVNPvjQaZvXbqopPZti3gDvjPaptqT2uiXfH/YmglROW+suDVH0NImdN/+/fX46t
	JZB2VexRhnMcg9FzWZ54jfDE4thok61Q98HQcwxe+tLOj/oNiNWpgVnU3ocs=
X-Google-Smtp-Source: AGHT+IFFuttMHqLS1NzNjjaUsptJHeOjOLiy3J4IGiKbJXBfuhvPakuAU9nJRFZCTzUYWTGc4g8XAg==
X-Received: by 2002:a05:6a21:339c:b0:244:21:b477 with SMTP id adf61e73a8af0-2602a59371fmr5525527637.16.1757718593795;
        Fri, 12 Sep 2025 16:09:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607c473b9sm6643028b3a.93.2025.09.12.16.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:53 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/4] PCI: Support FIXUP quirks in modules
Date: Fri, 12 Sep 2025 15:59:32 -0700
Message-ID: <20250912230208.967129-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI framework supports "quirks" for PCI devices via several
DECLARE_PCI_FIXUP_*() macros. These macros allow arch or driver code to
match device IDs to provide customizations or workarounds for broken
devices.

This mechanism is generally used in code that can only be built into the
kernel, but there are a few occasions where this mechanism is used in
drivers that can be modules. For example, see commit 574f29036fce ("PCI:
iproc: Apply quirk_paxc_bridge() for module as well as built-in").

The PCI fixup mechanism only works for built-in code, however, because
pci_fixup_device() only scans the ".pci_fixup_*" linker sections found
in the main kernel; it never touches modules.

Extend the fixup approach to modules.

I don't attempt to be clever here; the algorithm here scales with the
number of modules in the system.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/quirks.c   | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/module.h | 18 ++++++++++++
 kernel/module/main.c   | 26 ++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d97335a40193..db5e0ac82ed7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -207,6 +207,62 @@ extern struct pci_fixup __end_pci_fixups_suspend_late[];
 
 static bool pci_apply_fixup_final_quirks;
 
+struct pci_fixup_arg {
+	struct pci_dev *dev;
+	enum pci_fixup_pass pass;
+};
+
+static int pci_module_fixup(struct module *mod, void *parm)
+{
+	struct pci_fixup_arg *arg = parm;
+	void *start;
+	unsigned int size;
+
+	switch (arg->pass) {
+	case pci_fixup_early:
+		start = mod->pci_fixup_early;
+		size = mod->pci_fixup_early_size;
+		break;
+	case pci_fixup_header:
+		start = mod->pci_fixup_header;
+		size = mod->pci_fixup_header_size;
+		break;
+	case pci_fixup_final:
+		start = mod->pci_fixup_final;
+		size = mod->pci_fixup_final_size;
+		break;
+	case pci_fixup_enable:
+		start = mod->pci_fixup_enable;
+		size = mod->pci_fixup_enable_size;
+		break;
+	case pci_fixup_resume:
+		start = mod->pci_fixup_resume;
+		size = mod->pci_fixup_resume_size;
+		break;
+	case pci_fixup_suspend:
+		start = mod->pci_fixup_suspend;
+		size = mod->pci_fixup_suspend_size;
+		break;
+	case pci_fixup_resume_early:
+		start = mod->pci_fixup_resume_early;
+		size = mod->pci_fixup_resume_early_size;
+		break;
+	case pci_fixup_suspend_late:
+		start = mod->pci_fixup_suspend_late;
+		size = mod->pci_fixup_suspend_late_size;
+		break;
+	default:
+		return 0;
+	}
+
+	if (!size)
+		return 0;
+
+	pci_do_fixups(arg->dev, start, start + size);
+
+	return 0;
+}
+
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 {
 	struct pci_fixup *start, *end;
@@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 		return;
 	}
 	pci_do_fixups(dev, start, end);
+
+	struct pci_fixup_arg arg = {
+		.dev = dev,
+		.pass = pass,
+	};
+	module_for_each_mod(pci_module_fixup, &arg);
 }
 EXPORT_SYMBOL(pci_fixup_device);
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 3319a5269d28..7faa8987b9eb 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -539,6 +539,24 @@ struct module {
 	int num_kunit_suites;
 	struct kunit_suite **kunit_suites;
 #endif
+#ifdef CONFIG_PCI_QUIRKS
+	void *pci_fixup_early;
+	unsigned int pci_fixup_early_size;
+	void *pci_fixup_header;
+	unsigned int pci_fixup_header_size;
+	void *pci_fixup_final;
+	unsigned int pci_fixup_final_size;
+	void *pci_fixup_enable;
+	unsigned int pci_fixup_enable_size;
+	void *pci_fixup_resume;
+	unsigned int pci_fixup_resume_size;
+	void *pci_fixup_suspend;
+	unsigned int pci_fixup_suspend_size;
+	void *pci_fixup_resume_early;
+	unsigned int pci_fixup_resume_early_size;
+	void *pci_fixup_suspend_late;
+	unsigned int pci_fixup_suspend_late_size;
+#endif
 
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..50a80c875adc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					      sizeof(*mod->kunit_init_suites),
 					      &mod->num_kunit_init_suites);
 #endif
+#ifdef CONFIG_PCI_QUIRKS
+	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
+					    sizeof(*mod->pci_fixup_early),
+					    &mod->pci_fixup_early_size);
+	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
+					     sizeof(*mod->pci_fixup_header),
+					     &mod->pci_fixup_header_size);
+	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
+					    sizeof(*mod->pci_fixup_final),
+					    &mod->pci_fixup_final_size);
+	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
+					     sizeof(*mod->pci_fixup_enable),
+					     &mod->pci_fixup_enable_size);
+	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
+					     sizeof(*mod->pci_fixup_resume),
+					     &mod->pci_fixup_resume_size);
+	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
+					      sizeof(*mod->pci_fixup_suspend),
+					      &mod->pci_fixup_suspend_size);
+	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
+						   sizeof(*mod->pci_fixup_resume_early),
+						   &mod->pci_fixup_resume_early_size);
+	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
+						   sizeof(*mod->pci_fixup_suspend_late),
+						   &mod->pci_fixup_suspend_late_size);
+#endif
 
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
-- 
2.51.0.384.g4c02a37b29-goog


