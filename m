Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826B521D6D7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgGMNYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgGMNXO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD8FC061755;
        Mon, 13 Jul 2020 06:23:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so17185719ejx.0;
        Mon, 13 Jul 2020 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CqnQzLagV907q2DtZUmj9ucC67l45yw7G9UU01xV9po=;
        b=CRJ+eOrFMBo/lBjr7P0jG106EU1m3aA89WdMkojOKu0fhIqVbeWwawRT8c2JVTNVf6
         vH31cZc+hmYy4JBBDR1GYH0/j6xZ2sQS3lyKVAXc2BUnm7jDq4vfJKxzOR6ekWAjcZbt
         lhv/QnWokdFnxK9Z75zldkVpev4+Xi0Bvz9LWwdB9coyrcbhT/lzqGKB6zWUOPkFMsRo
         7Sfcg5A90uvkpFutYn8hHL4zypTFhA08sjDbl3TzVROBvggLbkYIcI5HcMXNgkZbyDx9
         7+sl9vXOKv3K49AtTf9xCaiB2I+3UQ0duNCCsFfLU16Poi4V9NQITTE4pjsukd7aUvof
         Z01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CqnQzLagV907q2DtZUmj9ucC67l45yw7G9UU01xV9po=;
        b=XJ3yKdz85q4KxX0PdnTV/fHzBcwTon8UtpXyVc8axwSxhcZ4UUzZO97xB1/ac9XiOL
         3SYE30LSNkxdLjDGFMrpszkdBeOzM0NYdO4i4eIl3bu6N+waQxQyK7p56axFXGFU+qRp
         rjYOFk8C/g4aOgjHPm7OLKrqOcWH2fUhCcZxOk+REr0STEuaprMmVqaGhmIBS1PD6k0h
         3KBeCDU7IDMWz6MxMhVOD9pRBJoa+u7G3fFi5AnHNlWNGQlDSDIxTBQpttbjy4PQCURr
         6xWVlcLxUwObnR95m5O1CrMPYMmYIL7M76Mdqc2KhSVzCF8sBoNNiO1Xz9qVtKzgIHym
         HOCA==
X-Gm-Message-State: AOAM53366iVZJVnTwN6O2Z6+Afd16jT/uzMSAfMVzah/bmXEgE5xXLMM
        +kvpnJyVnduZLSIDcrBeo38=
X-Google-Smtp-Source: ABdhPJxC1D2mvva5sNGWa1M2WUYKgdpW17USveAPUEU8MV+xucsXbvB99O2JawyIHGQPK2d7sUsGNg==
X-Received: by 2002:a17:906:b2c8:: with SMTP id cf8mr73669829ejb.132.1594646592134;
        Mon, 13 Jul 2020 06:23:12 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:11 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 26/35] powerpc: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:38 +0200
Message-Id: <20200713122247.10985-27-refactormyself@gmail.com>
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
 arch/powerpc/kernel/rtas_pci.c                 |  4 ++--
 arch/powerpc/platforms/4xx/pci.c               |  4 ++--
 arch/powerpc/platforms/52xx/efika.c            |  4 ++--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c      |  4 ++--
 arch/powerpc/platforms/82xx/pq2.c              |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c      |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c       |  2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c     |  2 +-
 arch/powerpc/platforms/chrp/pci.c              |  8 ++++----
 arch/powerpc/platforms/embedded6xx/holly.c     |  2 +-
 .../platforms/embedded6xx/mpc7448_hpc2.c       |  2 +-
 arch/powerpc/platforms/fsl_uli1575.c           |  2 +-
 arch/powerpc/platforms/maple/pci.c             | 18 +++++++++---------
 arch/powerpc/platforms/pasemi/pci.c            |  6 +++---
 arch/powerpc/platforms/powermac/pci.c          |  8 ++++----
 arch/powerpc/platforms/powernv/eeh-powernv.c   |  4 ++--
 arch/powerpc/platforms/powernv/pci.c           |  4 ++--
 arch/powerpc/platforms/pseries/eeh_pseries.c   |  4 ++--
 arch/powerpc/sysdev/fsl_pci.c                  |  2 +-
 arch/powerpc/sysdev/indirect_pci.c             |  4 ++--
 arch/powerpc/sysdev/tsi108_pci.c               |  4 ++--
 21 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 781c1869902e..18108ed9284c 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -71,7 +71,7 @@ int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 	if (ret)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rtas_pci_read_config(struct pci_bus *bus,
@@ -121,7 +121,7 @@ int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 	if (ret)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int rtas_pci_write_config(struct pci_bus *bus,
diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx/pci.c
index c13d64c3b019..3e6799d987d2 100644
--- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -1652,7 +1652,7 @@ static int ppc4xx_pciex_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	dcr_write(port->dcrs, DCRO_PEGPL_CFG, gpl_cfg);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int ppc4xx_pciex_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -1696,7 +1696,7 @@ static int ppc4xx_pciex_write_config(struct pci_bus *bus, unsigned int devfn,
 
 	dcr_write(port->dcrs, DCRO_PEGPL_CFG, gpl_cfg);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops ppc4xx_pciex_pci_ops =
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 4514a6f7458a..ef2584eb2dad 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -44,7 +44,7 @@ static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 
 	rval = rtas_call(rtas_token("read-pci-config"), 2, 2, &ret, addr, len);
 	*val = ret;
-	return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return rval ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -58,7 +58,7 @@ static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
 
 	rval = rtas_call(rtas_token("write-pci-config"), 3, 1, NULL,
 			 addr, len, val);
-	return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return rval ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static struct pci_ops rtas_pci_ops = {
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index af0f79995214..b9c2d0a7077e 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -157,7 +157,7 @@ mpc52xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	out_be32(hose->cfg_addr, 0);
 	mb();
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int
@@ -221,7 +221,7 @@ mpc52xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	out_be32(hose->cfg_addr, 0);
 	mb();
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops mpc52xx_pci_ops = {
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index 3b5cb39a564c..c15b3b0ed118 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -40,7 +40,7 @@ static int pq2_pci_exclude_device(struct pci_controller *hose,
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	else
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 }
 
 static void __init pq2_pci_add_bridge(struct device_node *np)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 172d2b7cfeb7..66f00eb2a8be 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -76,7 +76,7 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 	if ((bus == 0) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	else
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 }
 
 static int mpc85xx_cds_restart(struct notifier_block *this,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 2157a8017aa4..f33ac8e04da6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -118,7 +118,7 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 	if (hose->dn == pci_with_uli)
 		return uli_exclude_device(hose, bus, devfn);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 #endif	/* CONFIG_PCI */
 
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index b697918b727d..36b38b28d40b 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -49,7 +49,7 @@ static int mpc86xx_exclude_device(struct pci_controller *hose,
 	if (hose->dn == fsl_pci_primary)
 		return uli_exclude_device(hose, bus, devfn);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 #endif /* CONFIG_PCI */
 
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index b2c2bf35b76c..c8f8356607c7 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -55,7 +55,7 @@ static int gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
 		*val = in_le32(cfg_data);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
@@ -82,7 +82,7 @@ static int gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
 		out_le32(cfg_data, val);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops gg2_pci_ops =
@@ -106,7 +106,7 @@ static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 
 	rval = rtas_call(rtas_token("read-pci-config"), 2, 2, &ret, addr, len);
 	*val = ret;
-	return rval? PCIBIOS_DEVICE_NOT_FOUND: PCIBIOS_SUCCESSFUL;
+	return rval ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
@@ -120,7 +120,7 @@ static int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset
 
 	rval = rtas_call(rtas_token("write-pci-config"), 3, 1, NULL,
 			 addr, len, val);
-	return rval? PCIBIOS_DEVICE_NOT_FOUND: PCIBIOS_SUCCESSFUL;
+	return rval ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static struct pci_ops rtas_pci_ops =
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index d8f2e2c737bb..f9fca540c52a 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -47,7 +47,7 @@ static int holly_exclude_device(struct pci_controller *hose, u_char bus,
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	else
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 }
 
 static void holly_remap_bridge(void)
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 15437abe1f6d..34f6a0ecdf67 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -55,7 +55,7 @@ int mpc7448_hpc2_exclude_device(struct pci_controller *hose,
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	else
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 }
 
 static void __init mpc7448_hpc2_setup_arch(void)
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 044a20c1fbde..17c2cb5a8682 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -353,5 +353,5 @@ int uli_exclude_device(struct pci_controller *hose,
 			return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index c86a66d5e998..4e49f465056d 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -142,7 +142,7 @@ static int u3_agp_read_config(struct pci_bus *bus, unsigned int devfn,
 		*val = in_le32(addr);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int u3_agp_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -173,7 +173,7 @@ static int u3_agp_write_config(struct pci_bus *bus, unsigned int devfn,
 		out_le32(addr, val);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops u3_agp_pci_ops =
@@ -223,7 +223,7 @@ static int u3_ht_root_read_config(struct pci_controller *hose, u8 offset,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int u3_ht_root_write_config(struct pci_controller *hose, u8 offset,
@@ -234,7 +234,7 @@ static int u3_ht_root_write_config(struct pci_controller *hose, u8 offset,
 	addr = hose->cfg_addr + ((offset & ~3) << 2) + (4 - len - (offset & 3));
 
 	if (offset >= PCI_BASE_ADDRESS_0 && offset < PCI_CAPABILITY_LIST)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (len) {
 	case 1:
@@ -248,7 +248,7 @@ static int u3_ht_root_write_config(struct pci_controller *hose, u8 offset,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -286,7 +286,7 @@ static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
 		*val = in_le32(addr);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -323,7 +323,7 @@ static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
 		out_le32(addr, val);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops u3_ht_pci_ops =
@@ -397,7 +397,7 @@ static int u4_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
                 *val = in_le32(addr);
                 break;
         }
-        return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 static int u4_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
                                 int offset, int len, u32 val)
@@ -428,7 +428,7 @@ static int u4_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
                 out_le32(addr, val);
                 break;
         }
-        return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops u4_pcie_pci_ops =
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 8779b107d872..e558a402532a 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -166,7 +166,7 @@ static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (workaround_5945(bus, devfn, offset, len, val))
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
 
@@ -188,7 +188,7 @@ static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int pa_pxp_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -223,7 +223,7 @@ static int pa_pxp_write_config(struct pci_bus *bus, unsigned int devfn,
 		out_le32(addr, val);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops pa_pxp_ops = {
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index e35eaa9cf938..bdc9a89b5181 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -307,7 +307,7 @@ static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
 		default:
 			*val = 0xfffffffful; break;
 		}
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	default:
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -327,7 +327,7 @@ static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
 		*val = swap ? in_le32(addr) : in_be32(addr);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -350,7 +350,7 @@ static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
 	case 0:
 		break;
 	case 1:
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 	default:
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -370,7 +370,7 @@ static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
 		swap ? out_le32(addr, val) : out_be32(addr, val);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops u3_ht_pci_ops =
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 79409e005fcd..92f145dc9c1d 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -318,7 +318,7 @@ static int pnv_eeh_find_ecap(struct pci_dn *pdn, int cap)
 
 	if (!edev || !edev->pcie_cap)
 		return 0;
-	if (pnv_pci_cfg_read(pdn, pos, 4, &header) != PCIBIOS_SUCCESSFUL)
+	if (pnv_pci_cfg_read(pdn, pos, 4, &header) != 0)
 		return 0;
 	else if (!header)
 		return 0;
@@ -331,7 +331,7 @@ static int pnv_eeh_find_ecap(struct pci_dn *pdn, int cap)
 		if (pos < 256)
 			break;
 
-		if (pnv_pci_cfg_read(pdn, pos, 4, &header) != PCIBIOS_SUCCESSFUL)
+		if (pnv_pci_cfg_read(pdn, pos, 4, &header) != 0)
 			break;
 	}
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 091fe1cf386b..b3d5cc3e262a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -685,7 +685,7 @@ int pnv_pci_cfg_read(struct pci_dn *pdn,
 
 	pr_devel("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
 		 __func__, pdn->busno, pdn->devfn, where, size, *val);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 int pnv_pci_cfg_write(struct pci_dn *pdn,
@@ -710,7 +710,7 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 #if CONFIG_EEH
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index ace117f99d94..9c023b928f2c 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -200,7 +200,7 @@ static int pseries_eeh_find_ecap(struct pci_dn *pdn, int cap)
 
 	if (!edev || !edev->pcie_cap)
 		return 0;
-	if (rtas_read_config(pdn, pos, 4, &header) != PCIBIOS_SUCCESSFUL)
+	if (rtas_read_config(pdn, pos, 4, &header) != 0)
 		return 0;
 	else if (!header)
 		return 0;
@@ -213,7 +213,7 @@ static int pseries_eeh_find_ecap(struct pci_dn *pdn, int cap)
 		if (pos < 256)
 			break;
 
-		if (rtas_read_config(pdn, pos, 4, &header) != PCIBIOS_SUCCESSFUL)
+		if (rtas_read_config(pdn, pos, 4, &header) != 0)
 			break;
 	}
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 040b9d01c079..f1118c4443f4 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -697,7 +697,7 @@ static int mpc83xx_pcie_exclude_device(struct pci_bus *bus, unsigned int devfn)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
diff --git a/arch/powerpc/sysdev/indirect_pci.c b/arch/powerpc/sysdev/indirect_pci.c
index 09b36617425e..35b21276609b 100644
--- a/arch/powerpc/sysdev/indirect_pci.c
+++ b/arch/powerpc/sysdev/indirect_pci.c
@@ -70,7 +70,7 @@ int __indirect_read_config(struct pci_controller *hose,
 		*val = in_le32(cfg_data);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 int indirect_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -148,7 +148,7 @@ int indirect_write_config(struct pci_bus *bus, unsigned int devfn,
 		out_le32(cfg_data, val);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops indirect_pci_ops =
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 49f9541954f8..586dabb4e7ea 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -78,7 +78,7 @@ tsi108_direct_write_config(struct pci_bus *bus, unsigned int devfunc,
 		break;
 	}
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 void tsi108_clear_pci_error(u32 pci_cfg_base)
@@ -167,7 +167,7 @@ tsi108_direct_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		printk("data = 0x%x\n", *val);
 	}
 #endif
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 void tsi108_clear_pci_cfg_error(void)
-- 
2.18.2

