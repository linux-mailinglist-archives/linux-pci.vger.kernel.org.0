Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57B713BDB
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2019 20:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEDStl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 May 2019 14:49:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45314 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfEDStl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 May 2019 14:49:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so11887322wra.12
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2019 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwXn7yVJmbgSOURtftQXtQN2qS1l8Mf0tUcChgfSD5I=;
        b=KtWzctffz6/0Qx1RDBaYtjAUwRzEuDfgUDWTley2bKezfQKqjspDZZWXR6jxGiCe82
         K6mMKFWlTHtoYqrnfKrXnBqMrIMajabY+i9no6TbAKnDKZbaiNCPWAejC+aEN95nlzCn
         UNprJm5dvOy1wv5n47cYzKAJt1y9o2G8WHR2E86HwWQiuaHWibleQZip059eECOPaCdB
         sxN+FgetZq8Oe5Wyj04DeICRgfTH/CM4lay6D/2mC0IG3pV3/I66JKIB9BrBsI0hBddP
         4f8SJeDSywPS5iuCEMwkYnrMaRPdcIwACQLKeANLBp5b0Hkadvl4hd8MBb18L4m3O22k
         rN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwXn7yVJmbgSOURtftQXtQN2qS1l8Mf0tUcChgfSD5I=;
        b=Bc/+3QTo3wpPpUoLrsqcpKlh8NVa43DU1Qt2mQOf52wYct2ZmWVBkg4lTIn8A4MZ7X
         aW9/Nm6Vh0aqVK8ufz/A8MxzOo7bymvhwovbD9YUaF1btM4C7/ZNY6jICh5USgfBQ4U/
         XxYAuySGYjAnZAYZiO9I2cNUWfjHX0uFugmKovpINjTRI+6d+PbeZiDC9cSYvMod15An
         uFsAe1bUNeXvqo7eNI3VvYRaDHJHcqwD1NaMj2a+sTcF0iL4+fAzfdXcf50hJdlwRYIy
         o8tCE0DzlDzcy1jCEm964vHRMytj/NHk1GA4Yh6vXoPArUna6X+Xjoa5wCn5ZnFeSaCx
         9FQg==
X-Gm-Message-State: APjAAAXULZtn6yyHiTCr+5/kwMd+gg7kf2i/Ke9gw5rYIIXtFGkH6/8+
        vLpRxeUHtEpC2YTa3Z/0AXpqL5zifRc=
X-Google-Smtp-Source: APXvYqzOSQthQFOs2i/MNF+SAswtUmvLd4yS6JqlWl4oEIYG6/IjlMuk+/pvWRnpqn2Ca3NXAT4+QA==
X-Received: by 2002:adf:9f4a:: with SMTP id f10mr8342388wrg.13.1556995778542;
        Sat, 04 May 2019 11:49:38 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:b4f0:ef06:3998:44b4? (p200300EA8BD45700B4F0EF06399844B4.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:b4f0:ef06:3998:44b4])
        by smtp.googlemail.com with ESMTPSA id b10sm11304745wme.25.2019.05.04.11.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:49:37 -0700 (PDT)
Subject: Re: [PATCH RFC 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e63cec92-cfb1-d0c4-f21e-350b4b289849@gmail.com>
 <a0a39450-1f23-f5a0-d669-3d722e5b71dd@gmail.com>
 <20190430175304.GC145057@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <be1c5516-5777-cc9a-642b-4deb41f6439b@gmail.com>
Date:   Sat, 4 May 2019 20:49:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430175304.GC145057@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30.04.2019 19:53, Bjorn Helgaas wrote:
> On Sat, Apr 13, 2019 at 11:12:41AM +0200, Heiner Kallweit wrote:
>> Background of this extension is a problem with the r8169 network driver.
>> Several combinations of board chipsets and network chip versions have
>> problems if ASPM is enabled, therefore we have to disable ASPM per
>> default. However especially on notebooks ASPM can provide significant
>> power-saving, therefore we want to give users the option to enable
>> ASPM. With the new sysfs attribute users can control which ASPM
>> link-states are disabled.
> 
>> +void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>> +void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>>  #else
>>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>> -#endif
>> -
>> -#ifdef CONFIG_PCIEASPM_DEBUG
>> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>> -#else
> 
> I like the idea of exposing these sysfs control files all the time,
> instead of only when CONFIG_PCIEASPM_DEBUG=y, but I think when we do
> that, we should put the files at the downstream end of the link (e.g.,
> an endpoint) instead of at the upstream end (e.g., a root port or
> switch downstream port).  We had some conversation about this here:
> 
> https://lore.kernel.org/lkml/20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com
> 
> Doing it at the downstream end would require more changes, of course,
> and probably raises some locking issues, but I think we have a small
> window of opportunity here where we can tweak the sysfs structure
> before we're committed to supporting something forever.
> 
> Bjorn
> 

Here comes an updated version of patch 3. Unfortunately my test systems
don't allow OS ASPM control. At least the sysfs files are created for
the right devices (endpoints), and the attribute can be properly
controlled.


---
 drivers/pci/pci.h       |   8 +-
 drivers/pci/pcie/aspm.c | 171 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 171 insertions(+), 8 deletions(-)

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
index 7847be38e..f73539e5b 100644
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
@@ -1251,38 +1253,203 @@ static ssize_t clk_ctl_store(struct device *dev,
 
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
 
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT &&
+	    aspm_get_parent_link(pdev))
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
 
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT &&
+	    aspm_get_parent_link(pdev))
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


