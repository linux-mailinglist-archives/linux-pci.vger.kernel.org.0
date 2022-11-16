Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9862C56D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiKPQvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiKPQut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:50:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CBB1208E;
        Wed, 16 Nov 2022 08:49:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74527B81DFB;
        Wed, 16 Nov 2022 16:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E388EC433D6;
        Wed, 16 Nov 2022 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668617375;
        bh=VAFDprgM6w7FOLGVwkM8iPVVvSqgQuNzd6tbPutPWOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i1vHS5JM7e1vrCk1xFOU0C6Byb275qT2HJSd2hGKjzth775JIW22x0K9zPcQhd8S7
         RGN3bMso+90e0cbcFsMlX5ohXxh1Bh9Ezfi7e5YnvoTd7xfNu0qrIsSdSNJld7XXlr
         tcZMGKJOxo2oXhvLh3ubSk2XSbPDtdiuNMcVKIRqmId1NdOKEteD39y3pv4QBFJM4Z
         algaWvkuY1A4FI8T5lM5pcaYyFzkw4ZqbAEypOa5JmNsOz3cAWQa416P7r9N1H8ZMn
         7aCTF0hLppuay8Gw39EQ0FYkrNNpoPIRRuq9I0ZzvJj0evbcbVrPVmVtZHChKmJLau
         6/G39SdL6/yOw==
Date:   Wed, 16 Nov 2022 10:49:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 8/9] PCI: microchip: Partition inbound address
 translation
Message-ID: <20221116164933.GA1117375@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-9-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:55:03PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On Microchip PolarFire SoC the PCIe rootport is behind a set of fabric
> inter connect (fic) busses that encapsulate busses like ABP/AHP, AXI-S
> and AXI-M. Depending on which fic(s) the rootport is wired through to
> cpu space, the rootport driver needs to take account of the address
> translation done by a parent (e.g. fabric) node before setting up its
> own inbound address translation tables from attached devices.

Hi Daire, minor nits:

s/inter connect/interconnect/
s/fic/FIC/ ?  Sounds like an initialism similar to ABP, AHP, etc?
s/busses/buses/  Both ok, but "buses" much more common in drivers/pci/
s/cpu/CPU/
s/rootport/Root Port/  I try to follow PCIe spec usage.  Below you use
"root port" (with a space).  At least add the space to make consistent
here.

Some apply to previous commit logs, too, IIRC.

> +	/*
> +	 * check for one level up; will need to adjust
> +	 * address translation tables for these

Wrap to fill 78 columns or so.  Most existing comments in the file are
also capitalized per normal English conventions.
