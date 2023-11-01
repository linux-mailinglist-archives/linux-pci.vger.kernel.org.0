Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8106B7DE7FF
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 23:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjKAWRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 18:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjKAWRs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 18:17:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0AD10F;
        Wed,  1 Nov 2023 15:17:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B947C433C7;
        Wed,  1 Nov 2023 22:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698877064;
        bh=nyuKdgwIpK1RSgOQtbUwzcBNuY5rZc8qER6Dz4TIRyc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UflBDt7eftMRf/joBP5ipLEU5vb7LxjqOOPo6Y//N0ou+4VykFBQDrn2sn0EFqMpN
         qltZXQTFtplhDRN3HzOvYmkVOXyB+Zp0J2Qx0Hp0xwY0Ofli5NJnE5Mwx2ob445Eq5
         jyJ8ToYXBSlOGo0wp7KI3bKoUCZTHeN8oHq1zmyIkSCm2DH8h+Nc8XSCoagPC14z2S
         wxHkQM9qMxxDSDUk8EQtf3GLh2HcpKjCnpX7uop7MqfE+ph097h6GD+FN49pkbRayt
         MGih3nCC2YGNqJuDWB121pISv/c8PZx1eahzFxNKX5RYIUG9Vm6vgdsIPbZtLyu+RZ
         rQOvx+DMJTVdg==
Date:   Wed, 1 Nov 2023 17:17:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20231101221742.GA101112@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694066433-8677-6-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 07, 2023 at 11:30:33AM +0530, Krishna chaitanya chundru wrote:
> While scaling the interconnect clocks based on PCIe link speed, it is also
> mandatory to scale the power domain performance state so that the SoC can
> run under optimum power conditions.

Can you expand "OPP" somewhere so we know what it stands for?  I'm
sure everybody knows except me :)

This commit log says something is mandatory; can you phrase it so it
says what the patch actually *does*?  The subject is kind of a title,
and I think it's important for the log to make sense without the
subject, so it's OK if the log repeats part or all of the subject.

Bjorn
