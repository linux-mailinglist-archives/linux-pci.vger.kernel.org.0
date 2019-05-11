Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82B81A840
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2019 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfEKPde (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 May 2019 11:33:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33155 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbfEKPde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 May 2019 11:33:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so3183429wme.0
        for <linux-pci@vger.kernel.org>; Sat, 11 May 2019 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PIo1kzdqcuKGHagpL/QVikyzEtiiYx6iM3D8XOokS7Q=;
        b=slFOZyndjrL+k/jKA75cvYovV0hihFxwrmIylBTJSVWUzMGY+DITVi1a2i5ZwiPEbm
         fnIFHJSshHC9dCNFd+sNNuCwiutos4XD7FIdhpHzM8479dFZdOPzlKA98bsyXWqgvmXN
         QhqwPDcwjNM6Xvtfg2KfGfbcO4tYNFp4WjlQzIXV8cKFxhIThBxXfJnc9r4lEyS7I0sw
         um8j1p9zG75+W8kwR8FnxoOoDGzMo0BhVuEmMW/NvIIoLZ4ivJW/8FwchgJBdbd8cfnG
         elbjwRCBCQDrlG+XRm+ykTDWfAfmQ9gGVTT3HcC4VxAI1uV0JrPeGfY53M2Di5V6raxI
         ZLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PIo1kzdqcuKGHagpL/QVikyzEtiiYx6iM3D8XOokS7Q=;
        b=hWRRWwI6gI0bnkUF+3NqHGukhlPXNZppV5mqr6oLPnzQJDN+Ea0SfwlDXtMjBD+MQj
         Pda0UCsf5NU3LNvbGwtCDojmgCfVRKbfmB4rUCQQX/llYeLzSoGiedvFyXyN+WhWbhyQ
         N+EniuYXc0/jkhir+2zJsXh1V9ndnKzG7RAMfl3J8fRjLNGaIATtVW4MQ3qz/PdxErpi
         NXa/Nyzrtyw0xdkezLdzsMQFQsZ3oAHo1qqt6JEA9RLpgxy/MYoSI+qXX41Vn54g72qM
         +gopJo8A9b2rdy2q/v5FNitj/jkmHUXosVVq0fl1MW9xG2xETsxkQwIsBqQqRybGJzYP
         MU5Q==
X-Gm-Message-State: APjAAAVtCKzo7eH7rGutJ9Y5ON2Z1iIsH+SYCKsorO/J+21UFqnqFisy
        8b4IYaL41IQmNI6OP2DVRWCMRo1kgh4=
X-Google-Smtp-Source: APXvYqy8R/uaTw0zvVVP1vKNcdn7zTk+VdTIyRb6T7UPVWr97UdGGYq1WUAJ5xXszCXpjz3Fw66Ilg==
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr10052644wmf.116.1557588811698;
        Sat, 11 May 2019 08:33:31 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:152f:e071:7960:90b9? (p200300EA8BD45700152FE071796090B9.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:152f:e071:7960:90b9])
        by smtp.googlemail.com with ESMTPSA id d4sm22791150wrf.7.2019.05.11.08.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 08:33:31 -0700 (PDT)
Subject: [PATCH RFC v2 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
Message-ID: <773b6a8a-00ac-a275-c80b-d5909ca58f19@gmail.com>
Date:   Sat, 11 May 2019 17:33:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
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
none: allow all supported ASPM states
all: disable all ASPM states
+<state>: add state to list of disabled ASPM states
-<state>: re-enable ASPM state if supported

v2:
- bind attribute to the endpoint

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.h       |   8 +-
 drivers/pci/pcie/aspm.c | 181 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 181 insertions(+), 8 deletions(-)

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
index 7847be38e..530a2fbf0 100644
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
@@ -1251,38 +1253,213 @@ static ssize_t clk_ctl_store(struct device *dev,
 
 static DEVICE_ATTR_RW(link_state);
 static DEVICE_ATTR_RW(clk_ctl);
+#endif
+
+struct aspm_sysfs_state {
+	const char *name;
+	int disable_mask;
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
+static ssize_t aspm_disable_link_state_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
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
+		if (link->aspm_disable & st->disable_mask)
+			len += scnprintf(buf + len, PAGE_SIZE - len, "[%s] ",
+					 st->name);
+		else
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
+					 st->name);
+	}
+
+	if (link->clkpm_disable)
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
+static ssize_t aspm_disable_link_state_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
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
+				disable_aspm = 0;
+				disable_clkpm = 0;
+				break;
+			}
+			if (!strcasecmp(tok, "all")) {
+				disable_aspm = ASPM_STATE_ALL;
+				disable_clkpm = 1;
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
+					disable_aspm |= st->disable_mask;
+				else
+					disable_aspm &= ~st->disable_mask;
+				found = true;
+				break;
+			}
+		}
+
+		if (!found && !strcasecmp(tok, "clkpm")) {
+			disable_clkpm = add ? 1 : 0;
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
+static DEVICE_ATTR_RW(aspm_disable_link_state);
 
-static char power_group[] = "power";
 void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link_state = pdev->link_state;
 
+	if (pcie_check_aspm_endpoint(pdev))
+		sysfs_add_file_to_group(&pdev->dev.kobj,
+			&dev_attr_aspm_disable_link_state.attr, power_group);
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
+			&dev_attr_aspm_disable_link_state.attr, power_group);
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


