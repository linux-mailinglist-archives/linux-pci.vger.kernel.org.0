Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5ED2C8FB6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 22:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgK3VNR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 16:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbgK3VNQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 16:13:16 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6845C061A49
        for <linux-pci@vger.kernel.org>; Mon, 30 Nov 2020 13:12:04 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q3so3116366pgr.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Nov 2020 13:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQ9LlkkMxS2nc8KVid/xVdHfjgV0dxv/j2t4oViJb00=;
        b=FpgGNC2D5cix9E5RrsFlRcPreobJBvPaXkEklEW8f9H0s5BRTCvaugICn1nQz2xzD9
         EKHpW8aBfeabdWZNTdyu0FBJvL93FK+Qd41rh7lXGMwRoFTjlKm7pA3wou4jEpr35YPT
         mXxSrg7Pcqcwo7GKddSgBrGrMgx85ULrA7ou4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQ9LlkkMxS2nc8KVid/xVdHfjgV0dxv/j2t4oViJb00=;
        b=cf1Vt7dqJr/JTLYP6FWEqPsGtWis8b5uZxOH3RQUFNtBJJBds24T7hVNvJ8ZqJOktb
         5vH/2HosZ7wa4rRrDS/8bYllMr+FWWa1Yzuj87UdcLgx+Y7kcoOgms9LIkJQ5xjSRL+o
         TVvNYe8bvF01uA/Eu6kGtiVrE+jBtB434Tj7VtWi9xbM/RiAg32Isi4itpctae6IPseM
         61DcubQyFK3VQIj6c9onTLORCUvxRWHVUjNt+x1ar/+7dJtCVUm96XsUG1pLTsmEgQhb
         4tawdd+VFtlqsCfnQ41n5SaFO9yMQIT+3z3Kf4ognT+mNG191j34Jp2YwpLlHoaIdX98
         3HUw==
X-Gm-Message-State: AOAM533QdoQOqo+BIuxSEi46DQ4JwBvWHgjjGLt4hrE/tvRe4dbyABtZ
        F/uy3kUjxe4IsTCXhpbXHonk+eU+M9yYGTon5EegAFIDlLGmZO0bBKWZkiquKvDWsWNPrthnMLR
        xZ4Uyvs8hzPtQo0+m+bZOmcde5W03N/L+9nBHdOCopD/iG//ZUymoVFSKYwxe5ly7G3wCv//IAX
        yK8wCS
X-Google-Smtp-Source: ABdhPJwMd1CCQvBOAMbqF/0wJd5EeppOZWpk+YTnQgPqG8KZtSB3jjVuH2ZDtwVcb814gD9On3a0lw==
X-Received: by 2002:a62:4e15:0:b029:197:98e1:15c4 with SMTP id c21-20020a624e150000b029019798e115c4mr20817960pfb.39.1606770723827;
        Mon, 30 Nov 2020 13:12:03 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m7sm18320441pfh.72.2020.11.30.13.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:12:03 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/6] PCI: brcmstb: Do not turn off regulators if EP can wake up
Date:   Mon, 30 Nov 2020 16:11:40 -0500
Message-Id: <20201130211145.3012-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130211145.3012-1-james.quinlan@broadcom.com>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000041d5fe05b55976c2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--00000000000041d5fe05b55976c2

If any downstream device may wake up during S2/S3 suspend, we do not want
to turn off its power when suspending.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 58 +++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9d4ac42b3bee..cbdb315d4b2f 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -193,6 +193,7 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static bool brcm_pcie_link_up(struct brcm_pcie *pcie);
 
 enum {
 	RGR1_SW_INIT_1,
@@ -293,14 +294,57 @@ struct brcm_pcie {
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct regulator_bulk_data supplies[ARRAY_SIZE(ep_regulator_names)];
+	bool			ep_wakeup_capable;
 };
 
-static void brcm_set_regulators(struct brcm_pcie *pcie, bool on)
+static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
 {
+	bool *ret = data;
+
+	if (device_may_wakeup(&dev->dev)) {
+		*ret = true;
+		dev_dbg(&dev->dev, "disable cancelled for wake-up device\n");
+	}
+	return (int) *ret;
+}
+
+enum {
+	TURN_OFF,		/* Turn egulators off, unless an EP is wakeup-capable */
+	TURN_OFF_ALWAYS,	/* Turn Regulators off, no exceptions */
+	TURN_ON,		/* Turn regulators on, unless pcie->ep_wakeup_capable */
+};
+
+static void brcm_set_regulators(struct brcm_pcie *pcie, int how)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 	struct device *dev = pcie->dev;
 	int ret;
 
-	if (on)
+	if (how == TURN_ON) {
+		if (pcie->ep_wakeup_capable) {
+			/*
+			 * We are resuming from a suspend.  In the
+			 * previous suspend we did not disable the power
+			 * supplies, so there is no need to enable them
+			 * (and falsely increase their usage count).
+			 */
+			pcie->ep_wakeup_capable = false;
+			return;
+		}
+	} else if (how == TURN_OFF) {
+		/*
+		 * If at least one device on this bus is enabled as a
+		 * wake-up source, do not turn off regulators.
+		 */
+		pcie->ep_wakeup_capable = false;
+		if (bridge->bus && brcm_pcie_link_up(pcie)) {
+			pci_walk_bus(bridge->bus, pci_dev_may_wakeup, &pcie->ep_wakeup_capable);
+			if (pcie->ep_wakeup_capable)
+				return;
+		}
+	}
+
+	if (how == TURN_ON)
 		ret = regulator_bulk_enable(ARRAY_SIZE(ep_regulator_names),
 					    pcie->supplies);
 	else
@@ -308,7 +352,7 @@ static void brcm_set_regulators(struct brcm_pcie *pcie, bool on)
 					     pcie->supplies);
 	if (ret)
 		dev_err(dev, "failed to %s EP regulators\n",
-			on ? "enable" : "disable");
+			how == TURN_ON ? "enable" : "disable");
 }
 
 /*
@@ -1161,7 +1205,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	brcm_pcie_turn_off(pcie);
 	ret = brcm_phy_stop(pcie);
 	clk_disable_unprepare(pcie->clk);
-	brcm_set_regulators(pcie, false);
+	brcm_set_regulators(pcie, TURN_OFF);
 
 	return ret;
 }
@@ -1174,7 +1218,7 @@ static int brcm_pcie_resume(struct device *dev)
 	int ret;
 
 	base = pcie->base;
-	brcm_set_regulators(pcie, true);
+	brcm_set_regulators(pcie, TURN_ON);
 	clk_prepare_enable(pcie->clk);
 
 	ret = brcm_phy_start(pcie);
@@ -1213,7 +1257,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_phy_stop(pcie);
 	reset_control_assert(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
-	brcm_set_regulators(pcie, false);
+	brcm_set_regulators(pcie, TURN_OFF_ALWAYS);
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
@@ -1308,7 +1352,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	brcm_set_regulators(pcie, true);
+	brcm_set_regulators(pcie, TURN_ON);
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
 		goto fail;
-- 
2.17.1


--00000000000041d5fe05b55976c2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQQwYJKoZIhvcNAQcCoIIQNDCCEDACAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2YMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFRTCCBC2gAwIBAgIME79sZrUeCjpiuELzMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTA0MDcw
ODQ0WhcNMjIwOTA1MDcwODQ0WjCBjjELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMRQwEgYDVQQDEwtKaW0g
UXVpbmxhbjEpMCcGCSqGSIb3DQEJARYaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDqsBkKCQn3+AT8d+247+l35R4b3HcQmAIBLNwR78Pv
pMo/m+/bgJGpfN9+2p6a/M0l8nzvM+kaKcDdXKfYrnSGE5t+AFFb6dQD1UbJAX1IpZLyjTC215h2
49CKrg1K58cBpU95z5THwRvY/lDS1AyNJ8LkrKF20wMGQzam3LVfmrYHEUPSsMOVw7rRMSbVSGO9
+I2BkxB5dBmbnwpUPXY5+Mx6BEac1mEWA5+7anZeAAxsyvrER6cbU8MwwlrORp5lkeqDQKW3FIZB
mOxPm7sNHsn0TVdPryi9+T2d8fVC/kUmuEdTYP/Hdu4W4b4T9BcW57fInYrmaJ+uotS6X59rAgMB
AAGjggHRMIIBzTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAC
hkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEy
ZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVy
c29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8E
PTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJn
My5jcmwwJQYDVR0RBB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUaXKCYjFnlUSFd5GAxAQ2SZ17C2EwHQYDVR0OBBYEFNYm4GDl
4WOt3laB3gNKFfYyaM8bMA0GCSqGSIb3DQEBCwUAA4IBAQBD+XYEgpG/OqeRgXAgDF8sa+lQ/00T
wCP/3nBzwZPblTyThtDE/iaL/YZ5rdwqXwdCnSFh9cMhd/bnA+Eqw89clgTixvz9MdL9Vuo8LACI
VpHO+sxZ2Cu3bO5lpK+UVCyr21y1zumOICsOuu4MJA5mtkpzBXQiA7b/ogjGxG+5iNjt9FAMX4JP
V6GuAMmRknrzeTlxPy40UhUcRKk6Nm8mxl3Jh4KB68z7NFVpIx8G5w5I7S5ar1mLGNRjtFZ0RE4O
lcCwKVGUXRaZMgQGrIhxGVelVgrcBh2vjpndlv733VI2VKE/TvV5MxMGU18RnogYSm66AEFA/Zb+
5ztz1AtIMYICbzCCAmsCAQEwbTBdMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gMiBDQSAtIFNIQTI1NiAtIEcz
AgwTv2xmtR4KOmK4QvMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN/2tHIixzah
RmzTUvaX2yBCJ3A79RShEvqgv/NxAUDKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIwMTEzMDIxMTIwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCwEZ0+Ewb6mlAZUehywPEIYDEs30gT
7Gm7EMf4kfs9jj522LatKXLUEVOa5SwaXXnFMFnaAhjwM+CGsWkwiCzuG2xRI8y2Jnz3Qu+WCE4h
ATjBnuuBASa5EHHY3QPkgtEmLtUIZDahm/u1/PtiBh2nfPg9QnuXUR54P/ZsDyc68HDhClZwzYst
QJvHFUHsSwJWlcS3/7ykYRC3YVY4IYiN8rN3OlSoFhbgLnRosG3cBjZUy2YM2d34K0nTjZNhEXfB
pdBgr8hbD95splzrqmFhM1Nwuk1sRCNTL/SUpStNCtACJ24NDvSS9T700btEdWXHO1HlUns0TdIb
iR26xnYm
--00000000000041d5fe05b55976c2--
