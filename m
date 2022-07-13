Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5E4573C6F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGMSSJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGMSSI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 14:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9E12E6A2;
        Wed, 13 Jul 2022 11:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB4EF61D6F;
        Wed, 13 Jul 2022 18:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DB4C3411E;
        Wed, 13 Jul 2022 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657736287;
        bh=UiiI7ZQF6fW9XcgdR7ASAKtT4jh/y8Ot3nQUt4Q8KCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YwzUFjNh/NPPJ3CP5NByxyIOJMSovqEMhSA771v0Et6IGd8wgzKxAuNNSD8r3+RHa
         bBoJmL9H9dgozWlRhu56k+NGBpkniluCtWgjHeRCDY0xyKWw7Rb4uswsUjPR48w8Mf
         swxIMiyleL38BQaPcIYL7jc2y2KWtRQsteWgepEnCf/y0tfBawtlTxODwud9GNUQAS
         UvUrByHcQqhmHN1I8m+rmNRXivl7lmc4raZvN583y+kRLqXmHaMfpNtT+G+mSRbU54
         Uz3N7tFpRje6E8IMfTKkH44OVp9B/8wPb6qI13dRfWyc28JYXbNOskKf4VCNHhP60/
         +iI/qowucQa8A==
Date:   Wed, 13 Jul 2022 13:18:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: No controller seen in /sys/kernel/config/pci_ep/controllers
Message-ID: <20220713181805.GA841376@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8VuX6NrqyKQU1KS3DdTzZRQTdPK+nF0-eXXeQqhHyOypw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Kishon, endpoint maintainer, +cc LKML]

On Wed, Jul 13, 2022 at 12:53:06PM +0530, Ajay Garg wrote:
> Hello everyone.
> 
> The kernel has been built with :
> 
> ###################################
> CONFIG_PCI_ENDPOINT=y
> CONFIG_PCI_ENDPOINT_CONFIGFS=y
> CONFIG_PCI_EPF_TEST=y
> CONFIG_PCI_ENDPOINT_TEST=y
> ###################################
> 
> 
> Thereafter, following are seen :
> 
> ###################################
> $ sudo mount none /sys/kernel/config/ -t configfs
> mount: /sys/kernel/config: none already mounted or mount point busy.
> 
> $ ls -lrth /sys/class/pci_epc/
> total 0
> 
> $ ls -lrth /sys/kernel/config
> total 0
> drwxr-xr-x 4 root root 0 Jul 13 10:58 pci_ep
> drwxr-xr-x 2 root root 0 Jul 13 10:58 usb_gadget
> 
> $ ls -lrth /sys/kernel/config/pci_ep/functions
> total 0
> drwxr-xr-x 2 root root 0 Jul 13 10:58 pci_epf_test
> 
> $ ls -lrth /sys/kernel/config/pci_ep/controllers
> total 0
> 
> $
> ###################################
> 
> What is being missed?
> 
> Side Queries : Is the controller that is expected to be listed, a
> virtual-controller (like the one provided by CONFIG_USB_DUMMY_HCD in
> case of USB)?
> 
> Or there must be a real additional controller for pci-endpoint purpose?
> If yes, then :
> 
>               * I guess no listing is expected currently, as my machine has just
>                 one controller (as pci-host).
> 
>               * Is there a way to have an additional virtual pci-controller?
> 
> 
> Thanks and Regards,
> Ajay
