Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD774AC88F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiBGSbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 13:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiBGS2K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 13:28:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92639C0401DA;
        Mon,  7 Feb 2022 10:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3476060DC6;
        Mon,  7 Feb 2022 18:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F940C004E1;
        Mon,  7 Feb 2022 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644258488;
        bh=ETqd+yZ/HS9AXaGMHGmXNmo1b7Ei8h0Mz5rxIDEAYCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R0lPrTz1FVVpdU3QufS9iVKKMCmrC8ANQnsceUKDopylKuSrAc9ZWIg8FaEdCA+9m
         VJxfjTgBkmVzq+EQK9UR4ZWGhAWrmt2LELoJzDvV/+v8YG72iirrcJ3/ZAZQMkJygq
         AP0y+Pnj8ziGzIfx9FOdXP6gQZc/+MejhJTXPV7zpf4aIMZk5BRsaECWXVcuBBIUCc
         Om2hSoJ3n5oM8NCeOQ16Eoq3Ucy3BtjC8B3yQD/a2bzpBiwQnc71U/2OKmy1LQyGJl
         X/16Qrhf0kRAW+gGOKKNmb+/oW+VRYvzu8ik92egN9UhQfF0PBI4x5bYezTP/Fj+O3
         auwZo+RrVIF6w==
Date:   Mon, 7 Feb 2022 12:28:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, michals@xilinx.com
Subject: Re: [PATCH 1/2] PCI: xilinx-cpm: Update YAML schemas for Versal CPM5
 Root Port
Message-ID: <20220207182806.GA408432@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207041250.1658-2-bharat.kumar.gogada@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It looks like the subject line convention here would be something
like:

  dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port

(From "git log --oneline Documentation/devicetree/bindings/pci/")

On Mon, Feb 07, 2022 at 09:42:48AM +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root port
> functioning at Gen5 speed.
> Add support for YAML schemas documentation for Versal CPM5 Root Port driver.

s/Root port/Root Port/ to be consistent.
Add blank line between paragraphs.

Bjorn
