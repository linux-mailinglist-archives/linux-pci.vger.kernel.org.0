Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD321AC89
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfELNzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 09:55:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53820 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfELNzL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 09:55:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so11364679wme.3
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3l1d2foDP1ECMygrEI9oBUT1PrCGYJXFfOFHFE7lZOY=;
        b=aegJgOs/rAvppyNTapnke2//PI95YjIYB/g10YlWmZihQOtVhuqaQ5oHNjWcjK2kbE
         cjr2j1ZSvLn9O129AEeC+/Df3D5hn3C/3h/iG7lHp6/WIR1Llov+vpWSZ/rb2zu6TNWB
         8MH67W5eE0osRTtygitpbf7BFxVkxE09LK4SLaJB8MyUUzW0QR+YAnSmzzI/tSlPep/F
         vglTYzAd4Movljdygl7d28LG6Sq/XOM7enOhqrbfhAXwB0b8E6VIHcNIfXQXYUnyWiEv
         er0p4AQkihq458JGCUwUEUjS4QkquWblVx7UNAD9oJkHjNwamHv/fva49j5q3P3/lCkL
         UieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3l1d2foDP1ECMygrEI9oBUT1PrCGYJXFfOFHFE7lZOY=;
        b=alrr9Pc3b6clrcDsyen+BF3brri+fvLJQqNoYYnn+AVlwB/M+zN6tZodJqzG+sXvym
         2teqKuYpVPu1FapkNoIpO1I+gZSF8n6/a7216eOwcwFtXRGJRTH4ImUyE8cJ14rSiEyT
         R1VAqa7zMGrK4DOFRmD9YNIeAtoCYl7XuJbwivnpHY2MLRRKcd2cFFflbyMIykUIH2Uz
         U6WL1ItqtaprVrk2Ip6pZNy3HaGcpVUN6x76EINj9ENzMVakbjjLhDgYOg2SkVEYb7yy
         1R0YLRSeM1WXWi/Xic8I+HLu7P0fuCJTpyvlaalbvZugl5gNvOaRQgJX8AdN0mnC76jK
         RzEQ==
X-Gm-Message-State: APjAAAUocBQ5WsUr4SfTk62zI6B55reMDhxYgyvu+cct7BAp8FeMQocU
        b6/lkFQRJhDo/9oV+bxCnalEsm2+Sp4=
X-Google-Smtp-Source: APXvYqxXlkKrhjnaapaJd0TOlP4Se+1dG5T+bMsMsLNCrX0x5ncacdblI4aw3jIZb14mIibt6LhbrQ==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr13416819wmh.74.1557669308933;
        Sun, 12 May 2019 06:55:08 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3? (p200300EA8BD457009C2751D89ED5DAD3.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3])
        by smtp.googlemail.com with ESMTPSA id 19sm817513wmk.3.2019.05.12.06.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 06:55:08 -0700 (PDT)
Subject: [PATCH RFC v3 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
Message-ID: <061c2def-8998-d62e-a268-c5d1426b14f9@gmail.com>
Date:   Sun, 12 May 2019 15:54:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bde6db67-b432-f23c-5a44-d2cbb794ad40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Background of this extension is a problem with the r8169 network driver.
Several combinations of board chipsets and network chip versions have
problems if ASPM is enabled, therefore we have to disable ASPM per
default. However especially on notebooks ASPM can provide significant
power-saving, therefore we want to give users the option to enable
ASPM. With the new sysfs attribute users can control which ASPM
link-states are disabled.

This is a RFC version, therefore documentation of attribute is
still missing. The attribute handling was inspired by the protocol
attribute handling in drivers/media/rc/rc-main.c.
Attribute syntax in a few words:
none: disable all ASPM states
all: allow all supported ASPM states
-<state>: add state to list of disabled ASPM states
+<state>: re-enable ASPM state if supported

v2:
- bind attribute to the endpoint
v3:
- reverse semantics of attribute
- change attribute name to reflect changed semantics
---
 drivers/pci/pci.h       |   8 +-
 drivers/pci/pcie/aspm.c | 180 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 180 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9cb99380c..06642b7de 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -499,17 +499,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
+void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
-#endif
-
-#ifdef CONFIG_PCIEASPM_DEBUG
-void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
-void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
-#else
 static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
 static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
 #endif
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7847be38e..f3822accb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -42,6 +42,8 @@
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
 
+static const char power_group[] = "power";
+
 struct aspm_latency {
 	u32 l0s;			/* L0s latency (nsec) */
 	u32 l1;				/* L1 latency (nsec) */
@@ -1251,38 +1253,212 @@ static ssize_t clk_ctl_store(struct device *dev,
 
 static DEVICE_ATTR_RW(link_state);
 static DEVICE_ATTR_RW(clk_ctl);
+#endif
+
+struct aspm_sysfs_state {
+	const char *name;
+	int mask;
+};
+
+static const struct aspm_sysfs_state aspm_sysfs_states[] = {
+	{ "L0S",	ASPM_STATE_L0S		},
+	{ "L1",		ASPM_STATE_L1		},
+	{ "L1.1",	ASPM_STATE_L1_1_MASK	},
+	{ "L1.2",	ASPM_STATE_L1_2_MASK	},
+};
+
+static struct pcie_link_state *aspm_get_parent_link(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev->bus->self;
+
+	if (pdev->has_secondary_link)
+		parent = pdev;
+
+	return parent ? parent->link_state : NULL;
+}
+
+static bool pcie_check_aspm_endpoint(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	link = aspm_get_parent_link(pdev);
+
+	return link && link->aspm_support;
+}
+
+static ssize_t aspm_link_states_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	int len = 0, i;
+
+	link = aspm_get_parent_link(pdev);
+	if (!link)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&aspm_lock);
+
+	for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
+		const struct aspm_sysfs_state *st = aspm_sysfs_states + i;
+
+		if (link->aspm_enabled & st->mask)
+			len += scnprintf(buf + len, PAGE_SIZE - len, "[%s] ",
+					 st->name);
+		else
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
+					 st->name);
+	}
+
+	if (link->clkpm_enabled)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "[CLKPM] ");
+	else
+		len += scnprintf(buf + len, PAGE_SIZE - len, "CLKPM ");
+
+	mutex_unlock(&aspm_lock);
+
+	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+
+	return len;
+}
+
+static ssize_t aspm_link_states_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcie_link_state *link;
+	char *buftmp = (char *)buf, *tok;
+	unsigned int disable_aspm, disable_clkpm;
+	bool first = true, add;
+	int err = 0, i;
+
+	if (aspm_disabled)
+		return -EPERM;
+
+	link = aspm_get_parent_link(pdev);
+	if (!link)
+		return -EOPNOTSUPP;
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	disable_aspm = link->aspm_disable;
+	disable_clkpm = link->clkpm_disable;
+
+	while ((tok = strsep(&buftmp, " \n")) != NULL) {
+		bool found = false;
+
+		if (!*tok)
+			continue;
+
+		if (first) {
+			if (!strcasecmp(tok, "none")) {
+				disable_aspm = ASPM_STATE_ALL;
+				disable_clkpm = 1;
+				break;
+			}
+			if (!strcasecmp(tok, "all")) {
+				disable_aspm = 0;
+				disable_clkpm = 0;
+				break;
+			}
+			first = false;
+		}
+
+		if (*tok != '+' && *tok != '-') {
+			err = -EINVAL;
+			goto out;
+		}
+
+		add = *tok++ == '+';
+
+		for (i = 0; i < ARRAY_SIZE(aspm_sysfs_states); i++) {
+			const struct aspm_sysfs_state *st =
+						aspm_sysfs_states + i;
+
+			if (!strcasecmp(tok, st->name)) {
+				if (add)
+					disable_aspm &= ~st->mask;
+				else
+					disable_aspm |= st->mask;
+				found = true;
+				break;
+			}
+		}
+
+		if (!found && !strcasecmp(tok, "clkpm")) {
+			disable_clkpm = add ? 0 : 1;
+			found = true;
+		}
+
+		if (!found) {
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (disable_aspm & ASPM_STATE_L1)
+		disable_aspm |= ASPM_STATE_L1SS;
+
+	link->aspm_disable = disable_aspm;
+	link->clkpm_disable = disable_clkpm;
+
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+out:
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return err ?: len;
+}
+
+static DEVICE_ATTR_RW(aspm_link_states);
 
-static char power_group[] = "power";
 void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link_state = pdev->link_state;
 
+	if (pcie_check_aspm_endpoint(pdev))
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_link_states.attr, power_group);
+
 	if (!link_state)
 		return;
 
+#ifdef CONFIG_PCIEASPM_DEBUG
 	if (link_state->aspm_support)
 		sysfs_add_file_to_group(&pdev->dev.kobj,
 			&dev_attr_link_state.attr, power_group);
 	if (link_state->clkpm_capable)
 		sysfs_add_file_to_group(&pdev->dev.kobj,
 			&dev_attr_clk_ctl.attr, power_group);
+#endif
 }
 
 void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link_state = pdev->link_state;
 
+	if (pcie_check_aspm_endpoint(pdev))
+		sysfs_remove_file_from_group(&pdev->dev.kobj,
+			&dev_attr_aspm_link_states.attr, power_group);
+
 	if (!link_state)
 		return;
 
+#ifdef CONFIG_PCIEASPM_DEBUG
 	if (link_state->aspm_support)
 		sysfs_remove_file_from_group(&pdev->dev.kobj,
 			&dev_attr_link_state.attr, power_group);
 	if (link_state->clkpm_capable)
 		sysfs_remove_file_from_group(&pdev->dev.kobj,
 			&dev_attr_clk_ctl.attr, power_group);
-}
 #endif
+}
 
 static int __init pcie_aspm_disable(char *str)
 {
-- 
2.21.0

