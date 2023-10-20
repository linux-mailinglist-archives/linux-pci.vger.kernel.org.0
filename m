Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC67D0F5E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377162AbjJTMId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 08:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376909AbjJTMIc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 08:08:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8079E;
        Fri, 20 Oct 2023 05:08:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1539C433C7;
        Fri, 20 Oct 2023 12:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697803710;
        bh=lLWOS5rJtiPTgPtKrcPOA7lIim2pDnpVrtRpguMoa/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mERiYfPjVKAFFEGO2QfLinnZUClESIpUptwr4NkLdg2eA2NdYwldNuLHyGhfLT0dW
         GrEn2DtvIDItZDHnR+NsSkLp0c8XaCdt/K34CIomwFEYPYPx6AMRe0zh63m2Gm1lCw
         ZP2gHhP6ztwVaYD1Gr8P4eT7COEs6KaFcVgekDRuggbKuh9+K0RXDm3XZgLrPrVwmj
         XzH1T5A7wSaZz6BiutJIqh9Y0xJBlz4DSt/5wfJvTqaIs1tOwIlLefB2HERGdAaD3k
         Omulc8agheqVdhHBOC8xxM4F8G2GQbKK82hKlhzJ6ZA3tEVMxfRbCvsg+os5aF7X1N
         OPhzyXXxASJrQ==
Date:   Fri, 20 Oct 2023 07:08:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: Re: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as
 Root Port.
Message-ID: <20231020120828.GA1430425@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB720130851B21EAF714B7A41B8BDBA@SN7PR12MB7201.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 20, 2023 at 10:35:01AM +0000, Havalige, Thippeswamy wrote:
> Hi Bjorn,
> 
> Please can you provide an update on this patch series.

I'm hoping we can get this merged for v6.7.  There is quite a bit of
stuff outstanding, and if you have any time to help, your reviews of
other pending material would be very useful.

Bjorn
