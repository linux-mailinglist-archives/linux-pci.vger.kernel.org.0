Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B77700F44
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 21:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbjELTXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 15:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238343AbjELTXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 15:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5CF11D;
        Fri, 12 May 2023 12:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA1165832;
        Fri, 12 May 2023 19:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A37C433D2;
        Fri, 12 May 2023 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683919390;
        bh=rTYX7J2simoeeuACxS0/o1CfhbHwlLtl8PF1xd3jQw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=s6rJpRKLzf3BRa4o+kRe/k0zi00U/WlB1bfownwWQiMuV9WLZFpOWreEif2/NUyun
         bXpvuDLWUzr5CIE6rNgJEIAl8Z75opXP3j5Z+3LcVYFR7B0AlnB12NiZYi/ms3Juwh
         fIFsRB8V9tqb//gktmR7CJKukoaad8i9Z2FHvwumyIWbPORBJtiHl6DyRSxdf5+RqN
         BnCb976HEIVldWo4MdtSVjf5DaEsizn/65rAl1QURYdZ3oSKu5MftUNK9ZGwv+Er3Y
         ekeuY1onRnSaNti3Fi2/xkrvfOjQSQ5o6s/EcfWM8+7OCou5jHFElOVViYVKIqfIiy
         +caQA/AcEy8mQ==
Date:   Fri, 12 May 2023 14:23:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v2 1/3] Move error interrupt bits to a common header.
Message-ID: <ZF6SHJ44s4OqPYj4@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512062725.1208385-2-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update subject line to follow convention.  Run "git log --oneline
drivers/pci/controller/pcie-xilinx*" for a sample.  No period at end.

On Fri, May 12, 2023 at 11:57:23AM +0530, Thippeswamy Havalige wrote:
> Moving error interrupt bit macros to a common header file for code
> reusability.

"Move" as in subject.

Bjorn
