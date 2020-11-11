Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205C32AE95B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 08:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgKKHFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 02:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKHFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 02:05:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511EDC0613D1
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2020 23:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RyfMmKxZ4K4yWRwDorB1C1d2j3Xiow1odYV/wMQdCmo=; b=QXXbfIEdKzXXQlebD/DMQ3VKJI
        RmUPyRiRo3I/B974XiC9HSXKiWzVgFt7juTwL7PDmw30p+/CPeycX2TQVenCKtYyNpINjVm7KmNwg
        ACqo6YqmEdyi7jLmD2qfgnjLXF7RuX8Uqe8GsAOVFJokseizuTJlBid6MVzSLqPib83VCCfujD1Wa
        7BeuyAfpEnjrwjLd+mcXfJvZyYtYXcgRmqeUzJyagCWPdwEC5PaTp0uG5DuOvTx7egvr0wOas7llx
        AD+dPGCYaOeObpgZN/U3xWF7OXQ9Rubqr/IsqCxJIE4B+BcjiP5o8h8n3cYv9ScNyvps5pYLDASZh
        niBMzAdg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kckC8-0002Sc-S6; Wed, 11 Nov 2020 07:05:28 +0000
Date:   Wed, 11 Nov 2020 07:05:28 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] Expose PCIe SSD Status LED Management DSM in sysfs
Message-ID: <20201111070528.GA7829@infradead.org>
References: <20201110153735.58587-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110153735.58587-1-stuart.w.hayes@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 09:37:35AM -0600, Stuart Hayes wrote:
> +Date:		October 2020
> +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
> +Description:	If the device supports the ACPI _DSM method to control the
> +		PCIe SSD LED states, ssdleds_supported_states (read only)
> +		will show the LED states that are supported by the _DSM.
> +
> +What:		/sys/bus/pci/devices/.../ssdleds_current_state
> +Date:		October 2020
> +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
> +Description:	If the device supports the ACPI _DSM method to control the
> +		PCIe SSD LED states, ssdleds_current_state will show or set
> +		the current LED states that are active.

Is the supported file really required?  Doesn't the current_state one
also show which LEDs exist?

> +config PCI_SSDLEDS
> +	def_bool y if (ACPI && PCI)
> +	depends on PCI && ACPI

We really should not default new code to y.

> +	if (dsm_output->status != 0 &&
> +	    !(dsm_output->status == 4 && dsm_output->function_specific_err == 1)) {

overly longline.  But to make this a little more obvious, maybe you
want to

 a) switch on dsm_output->status
 b) add symbolic names for the magic numbers
