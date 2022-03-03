Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C484CC474
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 18:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiCCR63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 12:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCCR63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 12:58:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB686710D7;
        Thu,  3 Mar 2022 09:57:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6D9FB81DB8;
        Thu,  3 Mar 2022 17:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E72C340F0;
        Thu,  3 Mar 2022 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646330260;
        bh=hY8rAyb1zsetbVzg5OgbfUyuPVMG9GYiD0/OIrED5wE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MYtflfLlh9TiDIXibSAM3pECoM8IbJp/05QsspbsKvZKkl5j4EUgMmodgp2cjdhMF
         JTZmmwKMzxtj93Qne9s/wvdqDNlzdXG3hCnWhvtR6nVLTrQPaNra7nV1f90JR7QWSu
         7T1Zy72GRHqDvy5VKoVwueQpSXaAWRhn4Ua/a6QC0Xc6n1npHP9CFEe8JCH2CCH+2K
         5KLkN1opATv48ZWhgJx4cK5ypHTH6OP8R8nuErFkIY8gi+mEPrre+XgjPXlFqBzCXx
         CMelsAhubwzk4WOjMRd+12xrL1f5UMJWpla+zs15nXAbU5nLoizleMGTIYg+AqpWIs
         4/20pPLfFu4yg==
Date:   Thu, 3 Mar 2022 11:57:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?7J6l7JiB7KeEL1RWIFMvVyBMYWIoVkQpL1N0YWZmIEVuZ2luZWVyL+yCvA==?=
         =?utf-8?B?7ISx7KCE7J6Q?= <yj84.jang@samsung.com>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Pavel Machek' <pavel@ucw.cz>,
        'Len Brown' <len.brown@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-usb@vger.kernel.org, js07.lee@samsung.com
Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
Message-ID: <20220303175738.GA818511@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <044701d82e88$c5edb6f0$51c924d0$@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 03, 2022 at 07:56:37AM +0900, 장영진/TV S/W Lab(VD)/Staff Engineer/삼성전자 wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, March 3, 2022 5:16 AM
> > To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
> > Cc: �念��/TV S/W Lab(VD)/Staff Engineer/�Ｚ���� <yj84.jang@samsung.com>;
> > 'Rafael J. Wysocki' <rafael@kernel.org>; 'Pavel Machek' <pavel@ucw.cz>;
> > 'Len Brown' <len.brown@intel.com>; 'Bjorn Helgaas' <bhelgaas@google.com>;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-usb@vger.kernel.org;
> > js07.lee@samsung.com
> > Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
> > 
> > On Wed, Mar 02, 2022 at 03:52:51PM +0100, 'Greg Kroah-Hartman' wrote:
> > > On Wed, Mar 02, 2022 at 08:00:14PM +0900,  念  /TV S/W Lab(VD)/Staff
> > Engineer/ Ｚ     wrote:
> > > > > -----Original Message-----
> > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Sent: Wednesday, March 2, 2022 4:58 PM
> > > > > To: Youngjin Jang <yj84.jang@samsung.com>
> > > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Pavel Machek
> > > > > <pavel@ucw.cz>; Len Brown <len.brown@intel.com>; Bjorn Helgaas
> > > > > <bhelgaas@google.com>; linux-pm@vger.kernel.org;
> > > > > linux-kernel@vger.kernel.org; linux- pci@vger.kernel.org;
> > > > > linux-acpi@vger.kernel.org; linux-
> > > > usb@vger.kernel.org;
> > > > > js07.lee@samsung.com
> > > > > Subject: Re: [PATCH] PM: Add device name to
> > > > > suspend_report_result()
> > > > >
> > > > > On Wed, Mar 02, 2022 at 03:49:17PM +0900, Youngjin Jang wrote:
> > > > > > From: "yj84.jang" <yj84.jang@samsung.com>

> > > > > > -		pr_err("%s(): %pS returns %d\n", function, fn, ret);
> > > > > > +		pr_err("%s(): %pS (%s) returns %d\n", function, fn,
> > > > > > +dev_driver_string(dev), ret);
> > > > >
> > > > > If you have a struct device, please use dev_err().
> > > >
> > > > I think dev_err() is nice option, but we can see a minor issue.
> > > > Prefix log "PM: " would be lost, If I use dev_err() in this context.
> > > > As you know, all logs in power management include "PM :" prefix.
> > >
> > > Why does that matter?  Fix them all to use the struct device pointer
> > > and then they will be properly unified with the rest of the kernel log
> > > infrastructure.
> > 
> > You can #define dev_fmt if you need a prefix.
> 
> I tested dev_fmt before, but I feel that not a good solution.
> Because the readability is not so great than I expected.
> I didn't want to break the PM logging rules.

I didn't catch your meaning here.  Some examples would probably help.

The patch above is from __suspend_report_result() in
drivers/base/power/main.c.  That file already defines both pr_fmt and
dev_fmt to be "PM: ", so I would expect dev_err() output to already
include "PM: ".
