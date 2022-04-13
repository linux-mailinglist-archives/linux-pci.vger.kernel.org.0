Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3955002A4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 01:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiDMXeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 19:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbiDMXeM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 19:34:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38925283
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 16:31:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w19so6190184lfu.11
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tozqe/6KwOfp5sBl9FoatGnUEZcWim+p+d9DNp0gk5M=;
        b=AHg/qRhGNizu3zUbxlnHV81GkwAJ6cXWJ21GD/F23HhC7HB/AJwOMrHbuVe2PYteyq
         NqXkB/+lYmc/PAjCNk7/FJfxkAi1KNRfJgxo/zJ/N4CPDMPtpG7QJe01mWHNIHYqLQBA
         04nCW4ljh6Ft/7SKBeIIewt6wgbrsbe0XKjXwl8oGn6jWEkr7t1K7P13ssSRQkXcFVl7
         OPQSy7zQCJzgP/uYgRjdg/0QLEOK9NfW46Yj0rhWxLqSzh1t6UwnlFhpwm+vpNdO0qyZ
         HFXPKNZd6XMVMO3se3xN4fgJA0Qn0Nkst4fZazlAR9ltFu2NllSY2QmQxcAudW4mHfOF
         L7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tozqe/6KwOfp5sBl9FoatGnUEZcWim+p+d9DNp0gk5M=;
        b=n9jDeWb+314ZkRBL+/7TOgK3Ntp2jmcURXXtFEJRaQdpyxrY5cXa/wfHD0o1KEdvdI
         hLowP7kMF57BN4sCV6jR7Q7ro1tJZ6PosyDkjG/cdiLziRVw5ybXxr9IaFZT/TauFHfN
         ZOb7ds+GqoWhhY1Yt0covRhoExPrwUXy72uOCpCYboPsaDLuSnQy46D5W6LYImoMg6Vq
         Art0T6pwffeZ64J3R/Hxnbqv/zOrHVLHQxF500D25L3ZBd15HhqWE/cFCXOXBp4nPrFM
         iqNRpN2Hs55En5TM4uB8RvEFFCkM9ePNWOgcXH5C2Mv24RSwZvOvcSbDSjAvIiJUo++Q
         q3EQ==
X-Gm-Message-State: AOAM5315QBn2T+1obCw9rVwVJhWGXj70tgB5h/9yvg93n/+wer0ezAc/
        DFWhn9JrA0vMrmJw+6KoTNuG+A==
X-Google-Smtp-Source: ABdhPJwEHEU3FwXAPstKtu17DjUaKOLZAgmIVjvaB6mugv0wbhFcQxtWwbdZIZiR83+iX2gDpC5SEA==
X-Received: by 2002:a05:6512:33cb:b0:464:f5f4:22cb with SMTP id d11-20020a05651233cb00b00464f5f422cbmr68018lfg.186.1649892708150;
        Wed, 13 Apr 2022 16:31:48 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m5-20020a0565120a8500b0044a2963700fsm40982lfu.70.2022.04.13.16.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:31:47 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 2/6] clk: qcom: regmap-mux: add pipe clk implementation
Date:   Thu, 14 Apr 2022 02:31:40 +0300
Message-Id: <20220413233144.275926-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413233144.275926-1-dmitry.baryshkov@linaro.org>
References: <20220413233144.275926-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
muxes which must be parked to the "safe" source (bi_tcxo) when
corresponding GDSC is turned off and on again. Currently this is
handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
clock. However the same code sequence should be applied in the
pcie-qcom endpoint, USB3 and UFS drivers.

Rather than copying this sequence over and over again, follow the
example of clk_rcg2_shared_ops and implement this parking in the
enable() and disable() clock operations. As we are changing the parent
behind the back of the clock framework, also implement custom
set_parent() and get_parent() operations behaving accroding to the clock
framework expectations (cache the new parent if the clock is in disabled
state, return cached parent).

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/clk-regmap-mux.c | 121 ++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-mux.h |   3 +
 2 files changed, 124 insertions(+)

diff --git a/drivers/clk/qcom/clk-regmap-mux.c b/drivers/clk/qcom/clk-regmap-mux.c
index 45d9cca28064..fe61a9248f2f 100644
--- a/drivers/clk/qcom/clk-regmap-mux.c
+++ b/drivers/clk/qcom/clk-regmap-mux.c
@@ -49,9 +49,130 @@ static int mux_set_parent(struct clk_hw *hw, u8 index)
 	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
 }
 
+static u8 mux_safe_get_parent(struct clk_hw *hw)
+{
+	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
+	unsigned int val;
+
+	if (clk_hw_is_enabled(hw))
+		return mux_get_parent(hw);
+
+	val = mux->stored_parent;
+
+	if (mux->parent_map)
+		return qcom_find_src_index(hw, mux->parent_map, val);
+
+	return val;
+}
+
+static int mux_safe_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
+
+	if (clk_hw_is_enabled(hw))
+		return mux_set_parent(hw, index);
+
+	if (mux->parent_map)
+		index = mux->parent_map[index].src;
+
+	mux->stored_parent = index;
+
+	return 0;
+}
+
+static int mux_safe_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, mux->reg, &val);
+	val = (val & mask) >> mux->shift;
+
+	if (mux->parent_map) {
+		int src;
+
+		src = qcom_map_cfg_src(hw, mux->parent_map, val);
+		if (WARN_ON(src < 0))
+			return true;
+
+		return (unsigned int)src != mux->safe_src_parent;
+	}
+
+	return val != mux->safe_src_parent;
+}
+
+static void mux_safe_disable(struct clk_hw *hw)
+{
+	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, mux->reg, &val);
+
+	val = (val & mask) >> mux->shift;
+	if (mux->parent_map) {
+		int src, cfg;
+
+		src = qcom_map_cfg_src(hw, mux->parent_map, val);
+		if (WARN_ON(src < 0))
+			return;
+
+		mux->stored_parent = src;
+
+		cfg = qcom_map_src_cfg(hw, mux->parent_map, mux->safe_src_parent);
+		if (WARN_ON(cfg < 0))
+			return;
+
+		val = cfg;
+	} else {
+		mux->stored_parent = val;
+
+		val = mux->safe_src_parent;
+	}
+
+	val <<= mux->shift;
+
+	regmap_update_bits(clkr->regmap, mux->reg, mask, val);
+}
+
+static int mux_safe_enable(struct clk_hw *hw)
+{
+	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+	unsigned int val;
+
+	val = mux->stored_parent;
+	if (mux->parent_map) {
+		int cfg;
+
+		cfg = qcom_map_src_cfg(hw, mux->parent_map, val);
+		if (WARN_ON(cfg < 0))
+			return -EINVAL;
+
+		val = mux->parent_map[cfg].cfg;
+	}
+	val <<= mux->shift;
+
+	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
+}
+
 const struct clk_ops clk_regmap_mux_closest_ops = {
 	.get_parent = mux_get_parent,
 	.set_parent = mux_set_parent,
 	.determine_rate = __clk_mux_determine_rate_closest,
 };
 EXPORT_SYMBOL_GPL(clk_regmap_mux_closest_ops);
+
+const struct clk_ops clk_regmap_mux_safe_ops = {
+	.enable = mux_safe_enable,
+	.disable = mux_safe_disable,
+	.is_enabled = mux_safe_is_enabled,
+	.get_parent = mux_safe_get_parent,
+	.set_parent = mux_safe_set_parent,
+	.determine_rate = __clk_mux_determine_rate_closest,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_mux_safe_ops);
diff --git a/drivers/clk/qcom/clk-regmap-mux.h b/drivers/clk/qcom/clk-regmap-mux.h
index db6f4cdd9586..6fa5515b583c 100644
--- a/drivers/clk/qcom/clk-regmap-mux.h
+++ b/drivers/clk/qcom/clk-regmap-mux.h
@@ -14,10 +14,13 @@ struct clk_regmap_mux {
 	u32			reg;
 	u32			shift;
 	u32			width;
+	u8			safe_src_parent;
+	u8			stored_parent;
 	const struct parent_map	*parent_map;
 	struct clk_regmap	clkr;
 };
 
 extern const struct clk_ops clk_regmap_mux_closest_ops;
+extern const struct clk_ops clk_regmap_mux_safe_ops;
 
 #endif
-- 
2.35.1

