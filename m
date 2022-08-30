Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0008C5A6DCB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 21:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiH3TvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiH3TvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 15:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9762A88;
        Tue, 30 Aug 2022 12:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F67361706;
        Tue, 30 Aug 2022 19:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96906C433D7;
        Tue, 30 Aug 2022 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661889062;
        bh=RfuXFZr6s+SFZ0uKE1Z2fSMpP/WyczLTECOOZB51H6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZSnS4X6lUJAYSafV0NBM3Eq/CnK/EjsTlYw55ziL46wK6rJJkKFf3ZG9Zef1AcfXK
         Ehj+jZZt3n7xXKaX+IJWDsa2xnG2P1Tlw+OUN4Z7gXxKhxD7u1un8gQSIlQCQNvPAj
         +zxD/l27Cde3dB+e5abX4GITkMYccSsJ6RnX8MZ52zSHzUmIyQ4u/9/DeG5w37DANq
         SzBDNK9f2GrA/oVRfhMf0Nd+xrl6ljqWWVyH5Tuj9IFTuf/QppvxeW85PDbdet9gOs
         5N1SA7fcGdUbMZMtwvPluEYiHoTUr0HhE8dcVINsoFKJ9+ByQhjmjTa/OqKtuLsOlS
         akfa6p9zUWNLQ==
Date:   Tue, 30 Aug 2022 14:51:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v2 06/11] PCI: qcom-ep: Add debugfs support for expose
 link transition counts
Message-ID: <20220830195101.GA122107@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830165817.183571-7-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

  PCI: qcom-ep: Expose link transition counts via debugfs

On Tue, Aug 30, 2022 at 10:28:12PM +0530, Manivannan Sadhasivam wrote:
> Qualcomm PCIe controllers have the debug registers in the MMIO region
> that counts the PCIe link transitions. Let's expose them over debugfs to
> userspace to help debugging the low power issues.

s/have the debug/have debug/
s/that counts the/that count/
s/Let's expose/Expose/
s/to help debugging the/to help debug/
