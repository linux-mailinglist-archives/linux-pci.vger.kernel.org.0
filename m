Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFFB21D6C1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgGMNXY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbgGMNXX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43EC061755;
        Mon, 13 Jul 2020 06:23:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so13696619edm.4;
        Mon, 13 Jul 2020 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ewjye1h5mtnawh2b0AOy7diBdGFlRi1J1uZVkQ1ixro=;
        b=Mx+B1kxcYcsPVJySOuS4d7N3uwuf5I6uMC0zHSUAL7ZWfvZUlQF5NQZ0aFLz5I0Bhq
         gxmCdhWwq5HmX9AmIw06Rna+b//mOgyX6KAyM+CYVT+0xSFmrIZwDYuOXugeDIDM0gDP
         aInN5wj1Va1MCb1iogxcIzNjP4mJd7znHUSr2BajRZOc1bindC8LNZx+mmuBiurjvRol
         gA42M50Ze7Dg6mZxyeigQumPZ/jsYiOWKy77ccH4igWM/s758GiuqLXvuv0YS+MTDEPj
         CamZBn3Pcwwwk6lk6uk/ukorqPz9GVntJaklhFdFhwtlp8vbfEOmsBu6nf3NY6CSMVa2
         6oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ewjye1h5mtnawh2b0AOy7diBdGFlRi1J1uZVkQ1ixro=;
        b=NwERSWjThK+kAyN29Hx44dZrtiYL4PMQrU4rF45czMjTC2arNP40WAoNrrzKoaTX7q
         uEMzPzNDLIyLgcmEMK6++X21DjCzIJLQsG9y/znUjyuAW3OUf8SH2WqY1mt65VTy79Lw
         KsKNADpQPXeulA2TShibC1eL8PgGP1gX+vDoMCEcu6KrJU+7V+VcTQzEEOtmhlC+jf2y
         TWcc785AcEv9YE2u3CddOS5RBRhehkRgR047vmMPjxF7V1AuEmREVWXybHdyrXtOPe4h
         9pclzggdfP1KdNOr/rcgclQOOXDovf/jtAMgHGmGA2hySmgEZAoNfgvkslGFUNlHFQuN
         FMIw==
X-Gm-Message-State: AOAM530HCpwFe+1qOAX9GZkRLVV+berke78CGX2HVqZvbFOOEd4N2Spg
        wi7nq0tj5tcb5LRsALRrAEk=
X-Google-Smtp-Source: ABdhPJwjdCWmc5evl0WZ4tmvx/vOYmbbbwhXM2CIMv4V3vgcByzOPoi35qyT2hVPjVo+uxs6LAX+3Q==
X-Received: by 2002:a05:6402:359:: with SMTP id r25mr66129414edw.177.1594646602240;
        Mon, 13 Jul 2020 06:23:22 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:21 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 34/35] PCI: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:46 +0200
Message-Id: <20200713122247.10985-35-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 arch/alpha/kernel/core_apecs.c    | 4 ++--
 arch/alpha/kernel/core_cia.c      | 4 ++--
 arch/alpha/kernel/core_irongate.c | 4 ++--
 arch/alpha/kernel/core_lca.c      | 4 ++--
 arch/alpha/kernel/core_marvel.c   | 4 ++--
 arch/alpha/kernel/core_mcpcia.c   | 4 ++--
 arch/alpha/kernel/core_polaris.c  | 4 ++--
 arch/alpha/kernel/core_t2.c       | 4 ++--
 arch/alpha/kernel/core_titan.c    | 4 ++--
 arch/alpha/kernel/core_tsunami.c  | 4 ++--
 arch/alpha/kernel/core_wildfire.c | 4 ++--
 arch/alpha/kernel/sys_miata.c     | 2 +-
 12 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/alpha/kernel/core_apecs.c b/arch/alpha/kernel/core_apecs.c
index 6df765ff2b10..d74d78d92434 100644
--- a/arch/alpha/kernel/core_apecs.c
+++ b/arch/alpha/kernel/core_apecs.c
@@ -287,7 +287,7 @@ apecs_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 	shift = (where & 3) * 8;
 	addr = (pci_addr << 5) + mask + APECS_CONF;
 	*value = conf_read(addr, type1) >> (shift);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -304,7 +304,7 @@ apecs_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + APECS_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops apecs_pci_ops = 
diff --git a/arch/alpha/kernel/core_cia.c b/arch/alpha/kernel/core_cia.c
index f489170201c3..25300bc19c48 100644
--- a/arch/alpha/kernel/core_cia.c
+++ b/arch/alpha/kernel/core_cia.c
@@ -221,7 +221,7 @@ cia_read_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
 	shift = (where & 3) * 8;
 	addr = (pci_addr << 5) + mask + CIA_CONF;
 	*value = conf_read(addr, type1) >> (shift);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int 
@@ -238,7 +238,7 @@ cia_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
 	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + CIA_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops cia_pci_ops = 
diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index a9fd133a7fb2..858a2293c786 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -121,7 +121,7 @@ irongate_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -152,7 +152,7 @@ irongate_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops irongate_pci_ops =
diff --git a/arch/alpha/kernel/core_lca.c b/arch/alpha/kernel/core_lca.c
index 57e0750419f2..a7a00d73e2c5 100644
--- a/arch/alpha/kernel/core_lca.c
+++ b/arch/alpha/kernel/core_lca.c
@@ -213,7 +213,7 @@ lca_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + LCA_CONF;
 	*value = conf_read(addr) >> (shift);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int 
@@ -229,7 +229,7 @@ lca_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
 	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + LCA_CONF;
 	conf_write(addr, value << ((where & 3) * 8));
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops lca_pci_ops = 
diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
index 1db9d0eb2922..c076b97a9961 100644
--- a/arch/alpha/kernel/core_marvel.c
+++ b/arch/alpha/kernel/core_marvel.c
@@ -561,7 +561,7 @@ marvel_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -593,7 +593,7 @@ marvel_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops marvel_pci_ops =
diff --git a/arch/alpha/kernel/core_mcpcia.c b/arch/alpha/kernel/core_mcpcia.c
index 74b1d018124c..fdb6d055bcc0 100644
--- a/arch/alpha/kernel/core_mcpcia.c
+++ b/arch/alpha/kernel/core_mcpcia.c
@@ -216,7 +216,7 @@ mcpcia_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		*value = w;
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -233,7 +233,7 @@ mcpcia_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	addr |= (size - 1) * 8;
 	value = __kernel_insql(value, where & 3);
 	conf_write(addr, value, type1, hose);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops mcpcia_pci_ops = 
diff --git a/arch/alpha/kernel/core_polaris.c b/arch/alpha/kernel/core_polaris.c
index 75d622d96ff2..345b9d5a116f 100644
--- a/arch/alpha/kernel/core_polaris.c
+++ b/arch/alpha/kernel/core_polaris.c
@@ -102,7 +102,7 @@ polaris_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 
@@ -134,7 +134,7 @@ polaris_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops polaris_pci_ops = 
diff --git a/arch/alpha/kernel/core_t2.c b/arch/alpha/kernel/core_t2.c
index 98d5b6ff8a76..0bbf9b028c11 100644
--- a/arch/alpha/kernel/core_t2.c
+++ b/arch/alpha/kernel/core_t2.c
@@ -296,7 +296,7 @@ t2_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 	shift = (where & 3) * 8;
 	addr = (pci_addr << 5) + mask + T2_CONF;
 	*value = conf_read(addr, type1) >> (shift);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int 
@@ -313,7 +313,7 @@ t2_write_config(struct pci_bus *bus, unsigned int devfn, int where, int size,
 	mask = (size - 1) * 8;
 	addr = (pci_addr << 5) + mask + T2_CONF;
 	conf_write(addr, value << ((where & 3) * 8), type1);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops t2_pci_ops = 
diff --git a/arch/alpha/kernel/core_titan.c b/arch/alpha/kernel/core_titan.c
index 2a2820fb1be6..aac94708a226 100644
--- a/arch/alpha/kernel/core_titan.c
+++ b/arch/alpha/kernel/core_titan.c
@@ -158,7 +158,7 @@ titan_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int 
@@ -189,7 +189,7 @@ titan_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops titan_pci_ops = 
diff --git a/arch/alpha/kernel/core_tsunami.c b/arch/alpha/kernel/core_tsunami.c
index fc1ab73f23de..88fe80a8b41a 100644
--- a/arch/alpha/kernel/core_tsunami.c
+++ b/arch/alpha/kernel/core_tsunami.c
@@ -134,7 +134,7 @@ tsunami_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int 
@@ -165,7 +165,7 @@ tsunami_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops tsunami_pci_ops = 
diff --git a/arch/alpha/kernel/core_wildfire.c b/arch/alpha/kernel/core_wildfire.c
index e8d3b033018d..012ec2f5b675 100644
--- a/arch/alpha/kernel/core_wildfire.c
+++ b/arch/alpha/kernel/core_wildfire.c
@@ -400,7 +400,7 @@ wildfire_read_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int 
@@ -431,7 +431,7 @@ wildfire_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops wildfire_pci_ops = 
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index e1bee8f84c58..1b4c03ac34d8 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -185,7 +185,7 @@ miata_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	if((slot == 7) && (PCI_FUNC(dev->devfn) == 3)) {
 		u8 irq=0;
 		struct pci_dev *pdev = pci_get_slot(dev->bus, dev->devfn & ~7);
-		if(pdev == NULL || pci_read_config_byte(pdev, 0x40,&irq) != PCIBIOS_SUCCESSFUL) {
+		if (pdev == NULL || pci_read_config_byte(pdev, 0x40, &irq) != 0) {
 			pci_dev_put(pdev);
 			return -1;
 		}
-- 
2.18.2

