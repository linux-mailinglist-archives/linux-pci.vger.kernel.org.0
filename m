Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53B52E8028
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 13:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgLaM51 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 07:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgLaM50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 07:57:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F3BC06179B
        for <linux-pci@vger.kernel.org>; Thu, 31 Dec 2020 04:56:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h205so43878094lfd.5
        for <linux-pci@vger.kernel.org>; Thu, 31 Dec 2020 04:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTGZ/ohUNRbTjFJ7AFoie+4oyvbYi7rty13LxXQOIG0=;
        b=Lf0G4YG3IoEWxS/gyi5qqLOEhbBDzk3GDQcwcRoBjp5/J2rV6AJGVm4hHrn61odt0X
         zgAqspSfCw4J5dqcg6KBwNYyC5TTQgOKSLaHoItJ9I59qvb+HD6gvumWUjk+3G57WrhD
         1qYwV4YoXxF+xTVO1mnrMiMAxfkdKZng31iQLy7bsrpkII2LHWx+oiTh74p+87HB/J2t
         ncnN77q1Bgw+BACCZ3YtyRHxcalQXfO1D43mHQrT3RPaLrZFsd/GdKrX257dVfSd87KA
         JOmvyg16kUYstz7BYFk75PQr1ldN8wM4/1CL4kfW2pehU1KVowHEhKmtem7YkTK7jXgG
         u/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTGZ/ohUNRbTjFJ7AFoie+4oyvbYi7rty13LxXQOIG0=;
        b=RqSiAOe6Lyvd5g7BUxk4wDjnksDzE8IseOzfTvIehpbwD0jSeQSoX004kNnI+oqr7I
         WnAO0E8UzHcmAf4TBQf9Yt3fLYkW7zuIXMDy6i72ZCZdPvhUgGCAJa7W7dr5WfgiOmaw
         lbNgrLBxDaSzljqmCRmzGXANk/C516IL53PdUGJNFwDn6UU1AEmwD9nJKumqA499fa6b
         jnOwzCSetMW5ivjmkATv0eU2z/hbF6hxf8pK+pOosiUZaK2RYs04QAH+RspftpryEFoU
         Y0uZrTBSuaDU8df+c6p3V1aibMOFN7713CbgvC0Ei7qt7uUSXO0YqNBesOUpS/eh+mqU
         lYtQ==
X-Gm-Message-State: AOAM532vT6VT2ciiZaCk4AogtuatI9odAuvT83jh5Wnp3MepVfNLzz/3
        21Y9VuTUSl2+Jvl84Xir0/2sDKpthL+/RA==
X-Google-Smtp-Source: ABdhPJwsuh+AlYXEreFhiUSUiyUTRlt7hw+lOYUvGYBH1wcBcIVgcMWBYHI196hJYL1VzrrQYqVygw==
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr29328125ljn.471.1609419404582;
        Thu, 31 Dec 2020 04:56:44 -0800 (PST)
Received: from localhost.localdomain (85-76-98-107-nat.elisa-mobile.fi. [85.76.98.107])
        by smtp.gmail.com with ESMTPSA id r201sm6230659lff.268.2020.12.31.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:56:44 -0800 (PST)
From:   =?UTF-8?q?Jari=20H=C3=A4m=C3=A4l=C3=A4inen?= <nuumiofi@gmail.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jari=20H=C3=A4m=C3=A4l=C3=A4inen?= <nuumiofi@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 3/3] arm64: dts: rockchip: use bus-scan-delay-ms workaround with RockPro64 PCIe
Date:   Thu, 31 Dec 2020 14:52:14 +0200
Message-Id: <20201231125214.25733-4-nuumiofi@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231125214.25733-1-nuumiofi@gmail.com>
References: <20201231125214.25733-1-nuumiofi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add delay before RockPro64 PCIe bus scan as a workaround for some devices
causing a crash like many LSI SAS controller based RAID controllers and
host bus adapters.

As a side effect this slows down system startup by the amount of delay
even with devices that don't need the delay to work.

Signed-off-by: Jari Hämäläinen <nuumiofi@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6e553ff47534..256c357c069e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -546,6 +546,7 @@ &pcie0 {
 	num-lanes = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_perst>;
+	rockchip,bus-scan-delay-ms = <1100>;
 	vpcie12v-supply = <&vcc12v_dcin>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";
-- 
2.29.2

