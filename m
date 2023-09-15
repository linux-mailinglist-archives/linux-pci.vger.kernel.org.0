Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB47A1CCB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 12:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjIOKwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 06:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjIOKwH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 06:52:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535D1BB;
        Fri, 15 Sep 2023 03:51:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9189C433C8;
        Fri, 15 Sep 2023 10:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694775104;
        bh=talh/NkWsBDz48RkIKrwxmg28LGOW7LGlO2upewdPcw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o+GKAeQZaM2LG1EV2ycLk9P3SpeCtzSuR5Wz156h5Y3mtB7UYeBqv32VQ8pfMiV5i
         a7n94jbmCUp9+SGjci3qY+MYlT6wEk4iDjBj8u9vewCsJ/PlKhwEqOP7oXRb+1ib3Q
         u56KNuM2ptAlB0u7EuJMEMdZOYLSNKW+6avzs0loFtrOk5+8aPd3SRgAttSC7mhxBi
         pc/QO2nFKdckXVRpWC0Iawdmfw/Hg+OBCDrN14xjbT5QWUEmSKC/vVq4je7UhtbdjQ
         ubD2QIdbIjyNtPNUWAfCUVvKWv4rwtn1Tmd009EoIf+iyXOmKcfd5EtVXsi5zMQu2B
         z1BvEXrTCBZXQ==
Message-ID: <1dbe006d-0576-ac79-3774-fe262e5a532c@kernel.org>
Date:   Fri, 15 Sep 2023 05:51:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 0/2] PCI: altera: add support to agilex family
Content-Language: en-US
To:     sharath.kumar.d.m@intel.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230906110918.1501376-2-sharath.kumar.d.m@intel.com>
 <20230911135332.1777342-1-sharath.kumar.d.m@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230911135332.1777342-1-sharath.kumar.d.m@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/11/23 08:53, sharath.kumar.d.m@intel.com wrote:
> From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>
> 
> added new callback for
> 1) read,write to root port configuration registers
> 2) read,write to endpoint configuration registers
> 3) root port interrupt handler
> 
> agilex and newer platforms need to implemant the callback and generic root
> port driver should work ( without much changes ) , legacy platforms (arria
>   and startix) implement configuration read,write directly in wrapper
> api _altera_pcie_cfg_read/_altera_pcie_cfg_write
> 
> changelog v2:
> saperated into two patches
> 1.refactored the driver for easily portability to future Altera FPGA
> platforms
> 2.added support for "Agilex" FPGA
> 
> this driver supports PCI RP IP on Agilex FPGA, as these are FPGA its up
> to the user to add PCI RP or not ( as per his needs). we are not adding
> the device tree as part of this commit. we are expecting the add device
> tree changes only if he is adding PCI RP IP in his design
> 
> changelog v3:
> incorporate review comments from Bjorn Helgaas
> 
> 

You've sent 6 versions of this patchset in a 3-hour time span, what is 
going on?

Dinh

