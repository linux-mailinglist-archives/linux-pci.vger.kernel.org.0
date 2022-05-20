Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE7152E23F
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 04:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344638AbiETB66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 21:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbiETB65 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 21:58:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A009EC31A
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q130so8146870ljb.5
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/RGgCjrjOEbLbfHEEFuHyMmpO24+VFgBBynfKXgtyIM=;
        b=J70sy/b+kODyE8sX6VU4SZw12PlAp7i/jfF4poO2gJXZKTdKRXXUUifIDAg5L3KxrQ
         0Tp/kbQ2EskSalvywle65OKxf+uT6c2yLhnNqWAbicbXk8VX7akxcahwlaKABSQ1DZ1E
         70roULRQJZi6UQoPvgKWiriYcmwuhv377ZdTMacJVEDgsPYIkLVLI7Xxz8nRdrE+GayE
         d2xl91uFFi/+8yHoBQp50+cjFQK0Fq9yfRx4EYIpsacIQzZVCdTSvCOhh19vVcLwewr5
         nlu9+HxztReDvpP5XfUUJMjKzPAhFmWS3CZ9Kp/g5lftpqyohcofo62zMKH9iQKG0OSa
         ERCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RGgCjrjOEbLbfHEEFuHyMmpO24+VFgBBynfKXgtyIM=;
        b=MRi9vSPTbt/YIw2d9Mb8YgwN+NCGnBSe2NNXjZr56exyRHa0mr8C1Kmvi0iUJeF2tN
         jPREqp/BHlfYZ1fJwCNoEyA15h3rwdb07BpbX9wHlw+jbgY/nxbSU42dLcURK4yu0VQx
         ZIar57d9GzsTzgfPjP+2Dpepw11vHYOvJrFZmzCKquBg25+fU8A2pnHe+Bic3jasonYB
         wF9bFmyaPt6gp8QWdAdxGG/t94f/VnzkS5fsXsxaNxJ4++Es2MkPsa2r7eaCnckwNU4f
         TQOGxZOmIIjodDEHdiM0bv6yR9dXD9mqGngKX4rV6GocssjvdrIIpToqtcwMXih0LjdG
         dcAA==
X-Gm-Message-State: AOAM532NIooxJYJK0ciE2e46wORNHZ0duSXJPoiWdOWDhUnBW2ciHZeN
        SECzxgY62AcCU+BgGIA6AzTM3g==
X-Google-Smtp-Source: ABdhPJyNsAPgM7JA2LmxWJSVTVYH63TfPHWTFkaeHcVYR9HweENMo/QI0NYw8qux/kqByeeQyhBvww==
X-Received: by 2002:a2e:9b4e:0:b0:253:b917:aede with SMTP id o14-20020a2e9b4e000000b00253b917aedemr4304409ljj.275.1653011934473;
        Thu, 19 May 2022 18:58:54 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b0047255d21192sm467370lfq.193.2022.05.19.18.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 18:58:54 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 5/6] Revert "clk: qcom: regmap-mux: add pipe clk implementation"
Date:   Fri, 20 May 2022 04:58:43 +0300
Message-Id: <20220520015844.1190511-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
References: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
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

Johan Hovold has pointed out that there are several deficiencies and a
race condition in the regmap_mux_safe ops that were merged. Pipe clocks
has been updated to use newer and simpler clk_regmap_phy_mux_ops. Drop
the regmap-mux-safe clock ops now.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/clk-regmap-mux.c | 78 -------------------------------
 drivers/clk/qcom/clk-regmap-mux.h |  3 --
 2 files changed, 81 deletions(-)

diff --git a/drivers/clk/qcom/clk-regmap-mux.c b/drivers/clk/qcom/clk-regmap-mux.c
index c39ee783ee83..45d9cca28064 100644
--- a/drivers/clk/qcom/clk-regmap-mux.c
+++ b/drivers/clk/qcom/clk-regmap-mux.c
@@ -49,87 +49,9 @@ static int mux_set_parent(struct clk_hw *hw, u8 index)
 	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
 }
 
-static u8 mux_safe_get_parent(struct clk_hw *hw)
-{
-	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
-	unsigned int val;
-
-	if (clk_hw_is_enabled(hw))
-		return mux_get_parent(hw);
-
-	val = mux->stored_parent_cfg;
-
-	if (mux->parent_map)
-		return qcom_find_cfg_index(hw, mux->parent_map, val);
-
-	return val;
-}
-
-static int mux_safe_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
-
-	if (clk_hw_is_enabled(hw))
-		return mux_set_parent(hw, index);
-
-	if (mux->parent_map)
-		index = mux->parent_map[index].cfg;
-
-	mux->stored_parent_cfg = index;
-
-	return 0;
-}
-
-static void mux_safe_disable(struct clk_hw *hw)
-{
-	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
-	struct clk_regmap *clkr = to_clk_regmap(hw);
-	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
-	unsigned int val;
-
-	regmap_read(clkr->regmap, mux->reg, &val);
-
-	mux->stored_parent_cfg = (val & mask) >> mux->shift;
-
-	val = mux->safe_src_parent;
-	if (mux->parent_map) {
-		int index = qcom_find_src_index(hw, mux->parent_map, val);
-
-		if (WARN_ON(index < 0))
-			return;
-
-		val = mux->parent_map[index].cfg;
-	}
-	val <<= mux->shift;
-
-	regmap_update_bits(clkr->regmap, mux->reg, mask, val);
-}
-
-static int mux_safe_enable(struct clk_hw *hw)
-{
-	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
-	struct clk_regmap *clkr = to_clk_regmap(hw);
-	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
-	unsigned int val;
-
-	val = mux->stored_parent_cfg;
-	val <<= mux->shift;
-
-	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
-}
-
 const struct clk_ops clk_regmap_mux_closest_ops = {
 	.get_parent = mux_get_parent,
 	.set_parent = mux_set_parent,
 	.determine_rate = __clk_mux_determine_rate_closest,
 };
 EXPORT_SYMBOL_GPL(clk_regmap_mux_closest_ops);
-
-const struct clk_ops clk_regmap_mux_safe_ops = {
-	.enable = mux_safe_enable,
-	.disable = mux_safe_disable,
-	.get_parent = mux_safe_get_parent,
-	.set_parent = mux_safe_set_parent,
-	.determine_rate = __clk_mux_determine_rate_closest,
-};
-EXPORT_SYMBOL_GPL(clk_regmap_mux_safe_ops);
diff --git a/drivers/clk/qcom/clk-regmap-mux.h b/drivers/clk/qcom/clk-regmap-mux.h
index f86c674ce139..db6f4cdd9586 100644
--- a/drivers/clk/qcom/clk-regmap-mux.h
+++ b/drivers/clk/qcom/clk-regmap-mux.h
@@ -14,13 +14,10 @@ struct clk_regmap_mux {
 	u32			reg;
 	u32			shift;
 	u32			width;
-	u8			safe_src_parent;
-	u8			stored_parent_cfg;
 	const struct parent_map	*parent_map;
 	struct clk_regmap	clkr;
 };
 
 extern const struct clk_ops clk_regmap_mux_closest_ops;
-extern const struct clk_ops clk_regmap_mux_safe_ops;
 
 #endif
-- 
2.35.1

