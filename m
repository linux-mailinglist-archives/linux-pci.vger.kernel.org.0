Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC26B832C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 21:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCMUzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCMUzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 16:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2345291A;
        Mon, 13 Mar 2023 13:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DADB3614C1;
        Mon, 13 Mar 2023 20:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202D2C433D2;
        Mon, 13 Mar 2023 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678740936;
        bh=3vo69kqpsWbF0m1n8ErPDXv1g5eY2fX8t772YXd/DNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bF8uQriiSYLD+R+NxI+GWf0Ar59Jj3+Yn04ewxKitGrLzWQB51Hhibeejx2+2KRvX
         R4bLwncKkjD5aDy8PE078rWKDu7hpxHl95ECnj5Bxm9qzSC7sAcLhhFkSiWReAZnyS
         ZmyVVvRtkRa7vgo+NYco25JFm3IlNyG3EbdVex6f3dyUPAnu7wqzvwn2oeu61Msa5S
         kmeyA15CF1cfdyKGZWdi1OypfqSSJEqxeWyk9gdgtbAXcw/ZHk0p5IYDG1t9u104LR
         JiTFaaEF1C1OpoaQ2aHdlnkCXDeifxhS1R3w6iz+uv1hyUBhxjP4JRd8N3YqIPyQnA
         x4nCmFxIL7FOA==
Date:   Mon, 13 Mar 2023 15:55:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Use of_property_read_bool() for boolean
 properties
Message-ID: <20230313205534.GA1539457@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144720.1544531-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:19AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().

s/to to/to/
Likely can be fixed up when applying.
