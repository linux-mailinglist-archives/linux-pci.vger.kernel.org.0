Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE367CE9D8
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJRVPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJRVPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 17:15:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC15111
        for <linux-pci@vger.kernel.org>; Wed, 18 Oct 2023 14:15:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76277C433C8;
        Wed, 18 Oct 2023 21:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697663714;
        bh=541OJQZZt6If/VqM5cC6J2r7MpzdVfJplNYjBUrslv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ktfa5EIvOCFfXD6DFiHWyPJc0F7qso+jDBvmmINnJaHLUEgs5bLwmoN66GSS5ktU9
         lQkDVnnbmmKU4kC4WZaHPbX+4X4S9TazJdraZP69dpo0w4ruvZq0KuYtvUpdW905P2
         HRc+qF4CwJ0VKFsecM6EXIRHimgOqjV7VMN+TNsl1NRL/TDerUzLX6DYu1qpgOaBl4
         c+1WPFxBfvA33XMxcvBprng657svu1HVOtIm1y8K0r6LA5CTRCC5ecMG890LYvqfH4
         5aRPsOhz4W5pW+iIsWMKN+hTa5kbzeieSQbF/xh3xbyvR8eFItr8gF/hfre85VWqN6
         WU6rXHoGWhdyA==
Date:   Wed, 18 Oct 2023 16:15:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        sheenamo@google.com, justai@google.com,
        andriy.shevchenko@intel.com, joel.a.gibson@intel.com,
        emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
        mike.conover@intel.com, shaopeng.he@intel.com,
        anthony.l.nguyen@intel.com, pavan.kumar.linga@intel.com
Subject: Re: [PATCH v2 0/2] PCI: Disable ATS for specific Intel IPU E2000
 devices
Message-ID: <20231018211512.GA1378046@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908143606.685930-1-bartosz.pawlowski@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 08, 2023 at 02:36:04PM +0000, Bartosz Pawlowski wrote:
> This patch series addresses the problem with A an B steppings of
> Intel IPU E2000 which expects incorrect endianness in data field of ATS
> invalidation request TLP by disabling ATS capability for vulnerable
> devices.
> 
> v2:
> - Removed reference to SW workaround in code comment
> 
> Bartosz Pawlowski (2):
>   PCI: Extract ATS disabling to a helper function
>   PCI: Disable ATS for specific Intel IPU E2000 devices
> 
>  drivers/pci/quirks.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)

Applied to pci/ats for v6.7, thanks!
