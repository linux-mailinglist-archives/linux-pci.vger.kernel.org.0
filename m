Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B756D7D86B8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjJZQ3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 12:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZQ3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 12:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26D1183;
        Thu, 26 Oct 2023 09:29:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CD8C433C8;
        Thu, 26 Oct 2023 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698337752;
        bh=kcieYKh7VOQkUbzkqB4b7J2YKX+wO7GKMgjviDY9gSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j4dy4aWeerQ+uPDSD0h6ukp4VOQILTXQY6V7UgiRWqu5wvkQjBAvdyc38C2vfJlap
         3eCUS1UIK3l/E+X3KnUK3AcCFxUjo5WdnMI72VYHjQQcjrfNH6Y4B+LVxIIYArcNW+
         epOhoDi6Aih5uVVZjhAuOt7GA2bn9MDtIGDhS56zCDI3UnU09fpwba0Uy0rfQz521n
         /x71Y7cSCvHH3OS5Q1CgNm/9tN2GjJzcrqjY8kZZSVAo4SRxVyweq4J4wOsnMTVP4c
         YspzFNRivL3WL3SwCoIMEzkv+d2GSSH2PEnL6IMn57RmnaTpoqzt2piRBFeiilEx/m
         3cpBiZBj/U2OQ==
Date:   Thu, 26 Oct 2023 11:29:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/ASPM: Simplify
 pcie_capability_clear_and_set_word() to ..._clear_word()
Message-ID: <20231026162910.GA1824406@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231026121924.2164-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26, 2023 at 03:19:23PM +0300, Ilpo Järvinen wrote:
> When set parameter is 0, pcie_capability_clear_and_set_word() can be
> turned into pcie_capability_clear_word() which makes the intent of the
> code slightly more obvious.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Squashed and applied to pci/misc for v6.7, thanks!

> ---
>  drivers/pci/pcie/aspm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 1bf630059264..3b0508b47472 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -689,10 +689,10 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  	 * in pcie_config_aspm_link().
>  	 */
>  	if (enable_req & (ASPM_STATE_L1_1 | ASPM_STATE_L1_2)) {
> -		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
> -						   PCI_EXP_LNKCTL_ASPM_L1, 0);
> -		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> -						   PCI_EXP_LNKCTL_ASPM_L1, 0);
> +		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_ASPM_L1);
> +		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_ASPM_L1);
>  	}
>  
>  	val = 0;
> -- 
> 2.30.2
> 
