Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4AA743FE8
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjF3Qid (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjF3Qic (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 12:38:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5583A9B;
        Fri, 30 Jun 2023 09:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3BA161782;
        Fri, 30 Jun 2023 16:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D21C433C0;
        Fri, 30 Jun 2023 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688143111;
        bh=9F0WlbO8R869SouyiIylcXb48KO4BRuWNYId0kzGmGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dBmQkJOU0Ixr+c/H1pqFVXF0bQ5lRSszRbfP2otjxeSJA/5Eti9Kd17vnT6S/9c+c
         p72+TZ1I6Ip+0DvP1Dg1PzahovMWsp5OmTLRLmIw9NAFzcM0alJSHWJAhZiHxw8HkL
         /EGLYAvIq2R3R+fQQ9o7amffqPsQz9xPwYcxVCcHtmwzQr9/O/Qzm5ANNyXmeYGWg+
         zbqETEWwiDpVfBOfJMHhurrcXebHNgULCUtgep7AWdbv+36sjcC6NIKYmcqCIpP4Fc
         6qKlAGzfUMBT7u/vrTaa+H/YksxRZr/nIV/sM161sQQq88wXxiRZp1PPl3EBlr/VMZ
         hMFxRSlsOOjJQ==
Date:   Fri, 30 Jun 2023 11:38:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, yilun.xu@intel.com, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V1 RESEND 3/4] fpga: xrt: management physical function
 driver
Message-ID: <20230630163828.GA486259@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305052304.726050-4-lizhi.hou@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 04, 2022 at 09:23:03PM -0800, Lizhi Hou wrote:
> The PCIe device driver which attaches to management function on Alveo
> devices. The first version of this driver demonstrates calling PCIe
> interface to create device tree node.
> ...

> +static int __init xmgmt_init(void)
> +{
> +	int res;
> +
> +	res = pci_register_driver(&xmgmt_driver);
> +	if (res)
> +		return res;
> +
> +	return 0;

This is the same as:

  return pci_register_driver(&xmgmt_driver);

Bjorn
