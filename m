Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7350B57838A
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiGRNTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiGRNTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 09:19:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4FCC2E;
        Mon, 18 Jul 2022 06:19:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so12561594pjl.4;
        Mon, 18 Jul 2022 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K6cOdwUYhhUlLCQ8OAKwhRXbgdqK2kdqyGhsdqgptvQ=;
        b=IxYllnS8mdNEqHx4KGUk9e7Uzj85Y9OLP0pOC2UsLb6btN8FRh9yoRZ5s4a81mm2GL
         sZhOMckV2sXy95vzHO0zrCQiAc8t1jIKzvH1/jDufyQnD2KcerT+zimf3yKRL0Yk2ZYJ
         OZVleS53+x1M3Snaa9mT85QMK37D/OMhCQgZluU+4mUjW4ukjJae8NSapw8B/t4U1Fah
         scNpyvRuz+qASZyGvNTcqu4jyfnx9RbfZUw+ny1+Vv86GnQ/wxo8VanKy5o72iDGuqB1
         lJ32iBHoucs7cDtH/oHhCQL/WPaZ7H0jwpmGKDACVWqMyk2IfQwhFWJ2fdltbsT+40Ny
         s82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K6cOdwUYhhUlLCQ8OAKwhRXbgdqK2kdqyGhsdqgptvQ=;
        b=brtfrr7xsIGBDquUWN//qsmvMOdLw1T+qUwfXfFL6+iHeiZ4LhoDXZ+kXUc1gu3GE+
         A/HHugd9Asdq4EhFYA/d8i2GUSa+5lj8KZfkDta1rNubOYrvKLktDfP/0e49LxaYHbfr
         wMoamLn2PTdi+vKIzwK79lvhJuN65m/V3zn/AGagIxg28zS2mY0Ssd7ZZ79iibihB9VL
         egiKtlpdlZJi67f0UfuVE/whb6k+2e29cNwOJ6snsirBofMJijUdFpwyYp7v8XT86wCW
         Sk2d0DS+XXfMglhuTEz2lg6fDaz7w0tiI7DGDzlDwb8NUqDBtqXnhl4PsfmwGgLvR7vY
         HdHg==
X-Gm-Message-State: AJIora+LnYfjPKcU6E2DB+gN2ECu3gNauu7PEhgQMGXhXCvpN/C9spiS
        val+i7deyQxpLnFgiNUIvrI=
X-Google-Smtp-Source: AGRyM1tEg45BncQglD1UOqVTnZaN6yxmDNrJBIfk2QKl4b1+kHAqbAQ4j1B2N/cFvA514dH67u/CvA==
X-Received: by 2002:a17:90a:e7cd:b0:1f0:c82:c88f with SMTP id kb13-20020a17090ae7cd00b001f00c82c88fmr38290987pjb.100.1658150379172;
        Mon, 18 Jul 2022 06:19:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b0016be02d2a44sm9390076plb.133.2022.07.18.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:19:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Jul 2022 06:19:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v15 17/17] PCI: imx6: Reformat suspend callback to keep
 symmetric with resume
Message-ID: <20220718131900.GA4002775@roeck-us.net>
References: <1657783869-19194-1-git-send-email-hongxing.zhu@nxp.com>
 <1657783869-19194-18-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657783869-19194-18-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 14, 2022 at 03:31:09PM +0800, Richard Zhu wrote:
> Create imx6_pcie_stop_link() and imx6_pcie_host_exit() functions.
> Encapsulate clocks, regulators disables and PHY uninitialization into
> imx6_pcie_host_exit().
> 
> To keep suspend/resume symmetric as much as possible, invoke these two
> new created functions in suspend callback.
> 
> To be symmetric with imx6_pcie_host_exit(), move imx6_pcie_clk_enable()
> to imx6_pcie_host_init() from imx6_pcie_deassert_core_reset().
> 
> Link: https://lore.kernel.org/r/1656645935-1370-18-git-send-email-hongxing.zhu@nxp.com
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

If CONFIG_PM_SLEEP=n:

Error log:
drivers/pci/controller/dwc/pci-imx6.c:973:13: error: 'imx6_pcie_host_exit' defined but not used [-Werror=unused-function]
  973 | static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
      |             ^~~~~~~~~~~~~~~~~~~
drivers/pci/controller/dwc/pci-imx6.c:904:13: error: 'imx6_pcie_stop_link' defined but not used [-Werror=unused-function]
  904 | static void imx6_pcie_stop_link(struct dw_pcie *pci)

Guenter
