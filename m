Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D0328B3E
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfEWUFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 16:05:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38992 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387557AbfEWUFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 16:05:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so2942505wma.4
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zdDlqnYJIlV7gpzNe3dnj/pPwwf1pv/uvt4HC3KkAtc=;
        b=uxTq0YMQDt/CuQgiOUMiGI2Z+FegRZRmJdnK+sCfpSCkM/BvEoimGnvAUij+GCldqI
         4eXZuY7phIaNVb1W+XxDsyJY2jZi3kQyrdzukGX3oDl1z6UWaHQ5OngKoMljX1t7DgZj
         DCsMbel3GZLQE9onGHJkUUaa3Z7cUaC28Dm3nT6v3TAeZRvjf4ruFWQ7BT128CcREUAU
         JAdVNGSM1f3RvUJ4TPv+azsS1bDFbV8Bn9hkWPlhm2OclkRHsKJ6mAqABMw7eeYjJuN3
         MH/zm9dMEyda4rs0YwXKksa566j5lcKyVhbluVkY5EfB1ZuTE6Ajn+SE5uGgRjuf/kj2
         Ivdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdDlqnYJIlV7gpzNe3dnj/pPwwf1pv/uvt4HC3KkAtc=;
        b=rlJFvPhzA6FzjOvsiqvV7hz8pBoJRL4iqwCXg0qaAyQk8lptBddGEmFjWqyt0j61rC
         u3vup4ynCiHVDhKBTW2R79bCTXem1W2suh7Dh4HpybyJ2ObQeWnkSoRuxl0Cc7RqalZa
         TcQujdHCIcVLJmioCQrK+8glJ8EXl70DNBUoYnzjAWoPDzwEdQpQs9T8NbFE8XMb5ctA
         w+V0PqEf5mQJLMMHh/Gfr7Sa4tU036+QxtMO6Z8gafLmCouwgz7h71/ngby6aogmIQS7
         yPXwGlYmGCc9faf9ffJirdxiBd5rT7WlEts0B/8Dy8TOYeGHZgqHDRlOH/aguYSheYY+
         b9xg==
X-Gm-Message-State: APjAAAWIih6XHANwJOxhb8AHDYLxHsL1Bt6twBLeLy0WRs7pNr5n4MDv
        I268zhAbfAd5hsYTPbPhbkiXJL5P
X-Google-Smtp-Source: APXvYqzn7Psa8ux4+buHtEelV3qhWGzoCllXIKKkXYyPdQebfm+EvoM2LBixa9hZaYeU6/pD62W5CA==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr13831589wmc.28.1558641950088;
        Thu, 23 May 2019 13:05:50 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be9:7a00:3cd1:e8fe:d810:b3f0? (p200300EA8BE97A003CD1E8FED810B3F0.dip0.t-ipconnect.de. [2003:ea:8be9:7a00:3cd1:e8fe:d810:b3f0])
        by smtp.googlemail.com with ESMTPSA id p8sm406699wro.0.2019.05.23.13.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:05:49 -0700 (PDT)
Subject: [PATCH 3/3] PCI/ASPM: add sysfs attribute for controlling ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Message-ID: <a0c090cd-e3a4-f667-b99d-f31c48c2e0a3@gmail.com>
Date:   Thu, 23 May 2019 22:05:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Background of this extension is a problem with the r8169 network driver.
Several combinations of board chipsets and network chip versions have
problems if ASPM is enabled, therefore we have to disable ASPM per default.
However especially on notebooks ASPM can provide significant power-saving,
therefore we want to give users the option to enable ASPM. With the new sysfs
attribute users can control which ASPM link-states are enabled/disabled.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  13 ++
 drivers/pci/pci.h                       |   8 +-
 drivers/pci/pcie/aspm.c                 | 180 +++++++++++++++++++++++-
 3 files changed, 193 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 8bfee557e..38fe358de 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -347,3 +347,16 @@ Description:
 		If the device has any Peer-to-Peer memory registered, this
 	        file contains a '1' if the memory has been published for
 		use outside the driver that owns the device.
+
+What:		/sys/bus/pci/devices/.../power/aspm_link_states
+Date:		May 2019
+Contact:	Heiner Kallweit <hkallweit1@gmail.com>
+Description:
+		If ASPM is supported for an endpoint, then this file can be
+		used to enable / disable link states. A link state
+		displayed in brackets is enabled, otherwise it's disabled.
+		To control link states (case insensitive):
+		+state : enables a supported state
+		-state : disables a state
+		none : disables all link states
+		all : enables all supported link states
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


