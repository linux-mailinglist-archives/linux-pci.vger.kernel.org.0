Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6BB6115A1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJ1PQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJ1PQO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 11:16:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13793196EDF;
        Fri, 28 Oct 2022 08:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F4D3B82A02;
        Fri, 28 Oct 2022 15:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD71C433D6;
        Fri, 28 Oct 2022 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666970114;
        bh=02WuV/6Oxf4oaaL4sBi5+rFgJwnlkTCxNF7buk7z4Ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B2P022tTJlgBjHTZDrpky8xXpIGGFo/2oHNpXNFDvrgUSedzYNfFdd3smMnoJJSsc
         AdTizT7iNYVtfgm4dPKQAv08X+cVqjeJWzQRhzFjoL/309cBRg6L/v1ogB0fiEvtOQ
         45xQmnkYrdt4OaLydu+ibcLh9Dbp1OC6yvzJ/3YkX/yDPnDH7HQ78vUZ3FPVZSeg8f
         efAiE4eqyHNkfCspkeJDFzOQB/2weax8z0QK548O0GxJiUeEBOA14fLIt6+jbMjomA
         3dWgNIYjNe+IKl3o9hmDZJLedC0Q9dymsQlt3RrzvaBcJbNo2kdNwpmBs2xb0Uu4h/
         x63UWi2eHCz9w==
Date:   Fri, 28 Oct 2022 10:15:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, robert.moore@intel.com, ying.huang@intel.com,
        rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com
Subject: Re: [PATCH 0/5] Parse the PCIE AER structure and set to relevant
 registers
Message-ID: <20221028151512.GA889708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4096cf3-7f16-b20c-01ea-e235bc90ae77@zhaoxin.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 07:19:25PM +0800, LeoLiuoc wrote:
> 在 2022/10/27 12:17, Sathyanarayanan Kuppuswamy 写道:
> > On 10/26/22 8:14 PM, LeoLiu-oc wrote:

> > Can you add spec reference?
> > 
> Please refer to Section 18.3.2 ACPI Error Source of acpi spec v6.3. Links to
> the online versions of ACPI Spec 6.3 is
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/18_ACPI_Platform_Error_Interfaces/error-source-discovery.html#acpi-error-source.
> 
> Section 18.3.2.4 describes PCI Express Root Port AER Structure, section
> 18.3.2.5 describes PCI Express Device AER Structure, section 18.3.2.6
> describes PCI Express/PCI-X Bridge AER Structure.

Thanks.  It's OK to have the spec references in the email thread, but
the real point is that they should be in the commit log and, when it
makes sense, in code comments.

Cite the most recent spec version when you can.  In this case, I think
it is ACPI r6.5.

Personally I don't really care for URL references because they tend to
get stale over time as websites are reorganized and domains change.
Something like "ACPI r6.5, sec 18.3.2.4" is unambiguous and will
remain usable forever.

Bjorn
