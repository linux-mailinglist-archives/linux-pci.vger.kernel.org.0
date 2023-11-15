Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3417EC826
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 17:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjKOQGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 11:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjKOQG3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 11:06:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA1B6;
        Wed, 15 Nov 2023 08:06:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE9AC433C7;
        Wed, 15 Nov 2023 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700064386;
        bh=ijFaq7FHZJATJ08s9vGm2iuuP0507mTupYEi1E772CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtdBeZPKXhZlQDoGhhsQ6Rg8CPNzLfU8ZiL5xwHilVGxaiNZN0HjUxvrTmx4y/aoj
         ZxADUCZzrkVIppV+lpZtMLQyFwC0pTKMQbqH8aeNWQwu5phJ2UMkjRUbPp+Mb6Lzyl
         sZVud5XAICOyElMgVWrFskNLrBahx5bhRjMhu9Nx6LVeBwSLZGX2Gkir0pZDxL0DeL
         A5Q/OGSG+WlHYxGue9CNqvYnPcmFGRED4xGdvrHhbPmcsQFpjqbZP8y10RV59zFkUv
         M27T5yAJQUU6scCQOIRh/YhJBJKcVWMQuQDiUmzfDmYUd6dKOJT7jtoJl32Udfl6IA
         48418HHQBwRWA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3IPH-0006gS-1F;
        Wed, 15 Nov 2023 17:06:23 +0100
Date:   Wed, 15 Nov 2023 17:06:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 1/6] PCI/ASPM: Add locked helper for enabling link state
Message-ID: <ZVTsf9A05HQ9UYT-@hovoldconsulting.com>
References: <20231114135553.32301-2-johan+linaro@kernel.org>
 <202311152225.ZdVv0ufT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311152225.ZdVv0ufT-lkp@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 10:26:40PM +0800, kernel test robot wrote:
 
> >> drivers/pci/pcie/aspm.c:1186: warning: expecting prototype for pci_enable_link_state(). Prototype was for pci_enable_link_state_locked() instead
> 
> 
> vim +1186 drivers/pci/pcie/aspm.c
> 
>   1172	
>   1173	/**
>   1174	 * pci_enable_link_state - Clear and set the default device link state so that

I apparently forgot to update the name here to

	pci_enable_link_state_locked

[ ... ]

>   1184	 */
>   1185	int pci_enable_link_state_locked(struct pci_dev *pdev, int state)

Perhaps this can be fixed up when applying, or otherwise I'll respin.

Johan
