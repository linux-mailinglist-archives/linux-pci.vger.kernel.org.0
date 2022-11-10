Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B509624804
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiKJRLT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKJRLA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 12:11:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6503A4B99C;
        Thu, 10 Nov 2022 09:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EF05B82262;
        Thu, 10 Nov 2022 17:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72471C433C1;
        Thu, 10 Nov 2022 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668100257;
        bh=P8y8CmJlU1McSlaWZVB7GCSFqlAlNFeM9PX3F9Pd8os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P6gBEt2gyjfaimTUJQyL8IZ/tKscp3q3rD26rwLD3nqyOlMwSa3z+WoxfnuFoYLle
         pafSGwemv1ZRlaoYejad//tDxt0XPA0GHRlVqw3yLahE/7FFYiZAaDPm2FGr3nPPMQ
         idw8CKAZ2exFA62rIqoLOeeVPVSnAtPCErizURgUMSHog3XIc+S1iAaZeJNK1YYIA4
         8pVcsqwKCYYJcNQoxxm3QHYySTCG96RSvsthF6XUr3wA8rV/frTnGii1lHQj8l82+p
         qymNTKgP71JhVzbvbtD53ApNYHjA+IpFPb7H4ZNeIOz4L2ygU9oUW9j1dFi61bxGzu
         h8q0tBtCcOwbQ==
Date:   Thu, 10 Nov 2022 11:10:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "rrichter@amd.com" <rrichter@amd.com>,
        "terry.bowman@amd.com" <terry.bowman@amd.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] cxl/acpi: Set ACPI's CXL _OSC to indicate CXL1.1
 support
Message-ID: <20221110171055.GA627971@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d0da6a410ca49c1b70628a2a4814bdf2cbfce58.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 12:51:02AM +0000, Verma, Vishal L wrote:
> On Wed, 2022-11-09 at 17:35 -0600, Bjorn Helgaas wrote:

> > I don't know the history, but OSC_CXL_1_1_PORT_REG_ACCESS_SUPPORT and
> > OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT seem like sort of weird names
> > since they don't match the spec at all ("RCD and RCH Port Register
> > Access Supported" and "CXL VH Register Access Supported").
> 
> Ah the RCH/RCD and VH terminology was only introduced in the CXL-3.0
> spec. When the above defines were added, the spec was at 2.0, and it
> used the descriptions: "CXL 1.1 Port Register Access supported", and
> "CXL 2.0 Port/Device Register Access supported" (Table 217 in 2.0).

Haha, that's annoying :)  I didn't dig back through the old versions.
I guess CXL folks can decide whether to keep the old names or update.
