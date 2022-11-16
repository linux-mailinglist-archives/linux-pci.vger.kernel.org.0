Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECEA62C5B2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiKPRB7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiKPRBa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:01:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062324F10;
        Wed, 16 Nov 2022 09:01:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F00961EE6;
        Wed, 16 Nov 2022 17:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5287C433C1;
        Wed, 16 Nov 2022 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668618088;
        bh=NgoF6H00h3ybNCo6l/K8tFBS2V1ks1ySzik7gT4hXNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRoPIvZpsWLj/7UGSIdWIPvQjcFJalHa573TZ/VHCv4kLyK287rBf6Z1Xqy7Dc7RQ
         7+TjvseRIv9wT9LpnMD52pFutfEuKT0QHDyZav2PKs+gFCG28hGSj1Qy1lYur1Jw6x
         15B5y5ElxGxS6OVvFMWFZfjCsnQlUVEDT/P+GwI1sqRCuniXNLzVZfkP0JTJQ8qblq
         MdTs48N9/9C1PNgkpN8FJgX1/TAl3oBnRdZvUVF1l6Oz60WDsEGObd9wJNoa64gN2g
         /J7VNSVF+ezMZx1AAAPOJ9/rfI0OqFlqZjJ99CZuU1vY0mAuvyvHSkyCTP9r0ndMu8
         JbduaOG9bh5Fg==
Date:   Wed, 16 Nov 2022 17:01:23 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, daire.mcnamara@microchip.com
Cc:     daire.mcnamara@microchip.com, conor.dooley@microchip.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 8/9] PCI: microchip: Partition inbound address
 translation
Message-ID: <Y3UXYyyJUE0WexxD@spud>
References: <20221116135504.258687-9-daire.mcnamara@microchip.com>
 <20221116164933.GA1117375@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116164933.GA1117375@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 10:49:33AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 16, 2022 at 01:55:03PM +0000, daire.mcnamara@microchip.com wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> > 
> > On Microchip PolarFire SoC the PCIe rootport is behind a set of fabric
> > inter connect (fic) busses that encapsulate busses like ABP/AHP, AXI-S
> > and AXI-M. Depending on which fic(s) the rootport is wired through to
> > cpu space, the rootport driver needs to take account of the address
> > translation done by a parent (e.g. fabric) node before setting up its
> > own inbound address translation tables from attached devices.
> 
> Hi Daire, minor nits:
> 
> s/inter connect/interconnect/
> s/fic/FIC/ ?  Sounds like an initialism similar to ABP, AHP, etc?

Daire, we've been living a lie. The TRM says "Fabric Interface
Controllers (FICs)" so I think we should switch the that wording.
Fits the acronym better too..

