Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8085150B8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379047AbiD2Q3N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 12:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379048AbiD2Q3L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 12:29:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF14D4C4E;
        Fri, 29 Apr 2022 09:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 345EBB83238;
        Fri, 29 Apr 2022 16:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F6CC385A4;
        Fri, 29 Apr 2022 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651249548;
        bh=BWS82VVFyGkq8byIrn9E10Tw1cwiTndaAE5gu1B1OmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CVIs8SdxCsEVj5dUFPoP75L/KJ26GD43iGVck/aZNGhK1aezz7ZZb06FSUfWiMU00
         TXb+1854FvHtiQPJaNkNykibUp1cgY1oD2iObIkRxs2MoTYcJb63woOZPMZR+SDGcU
         3HNVtaNPwoV85OfwP4/4RrLNA8cIYKZ8K7ZEC1wEKqUE7zEsAtpg+Sc7WIPoW36o3E
         l4BqKcJyvXW/5tH7ZOLJG6rEOYNvav4eMgUMApp2OOvJvYo/J+DJZ4ArXiMOT84Bha
         LcuibEvm3xCMlzVtrEPQulC95eJG+GMWrxVeoahXaCXso46F+NgWRtTC/XTK12qu/A
         mlhrBbOUrkG0g==
Date:   Fri, 29 Apr 2022 11:25:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6] PCI hotplug: rpaphp: Error out on busy status from
 get-sensor-state
Message-ID: <20220429162545.GA79541@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0b8q1px.fsf@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 28, 2022 at 05:31:38PM -0500, Nathan Lynch wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Tue, Apr 26, 2022 at 11:07:39PM +0530, Mahesh Salgaonkar wrote:
> >> +/*
> >> + * RTAS call get-sensor-state(DR_ENTITY_SENSE) return values as per PAPR:
> >> + *    -1: Hardware Error
> >> + *    -2: RTAS_BUSY
> >> + *    -3: Invalid sensor. RTAS Parameter Error.
> >> + * -9000: Need DR entity to be powered up and unisolated before RTAS call
> >> + * -9001: Need DR entity to be powered up, but not unisolated, before RTAS call
> >> + * -9002: DR entity unusable
> >> + *  990x: Extended delay - where x is a number in the range of 0-5
> >> + */
> >> +#define RTAS_HARDWARE_ERROR	(-1)
> >> +#define RTAS_INVALID_SENSOR	(-3)
> >> +#define SLOT_UNISOLATED		(-9000)
> >> +#define SLOT_NOT_UNISOLATED	(-9001)

> >> +static int rtas_to_errno(int rtas_rc)
> >> +{
> >> +	int rc;
> >> +
> >> +	switch (rtas_rc) {
> >> +	case RTAS_HARDWARE_ERROR:
> >> +		rc = -EIO;
> >> +		break;
> >> +	case RTAS_INVALID_SENSOR:
> >> +		rc = -EINVAL;
> >> +		break;
> >> +	case SLOT_UNISOLATED:
> >> +	case SLOT_NOT_UNISOLATED:
> >> +		rc = -EFAULT;
> >> +		break;
> >> +	case SLOT_NOT_USABLE:
> >> +		rc = -ENODEV;
> >> +		break;
> >> +	case RTAS_BUSY:
> >> +	case RTAS_EXTENDED_DELAY_MIN...RTAS_EXTENDED_DELAY_MAX:
> >> +		rc = -EBUSY;
> >> +		break;
> >> +	default:
> >> +		err("%s: unexpected RTAS error %d\n", __func__, rtas_rc);
> >> +		rc = -ERANGE;
> >> +		break;
> >> +	}
> >> +	return rc;
> >
> > This basically duplicates rtas_error_rc().  Why do we need two copies?
> 
> It treats RTAS_BUSY, RTAS_EXTENDED_DELAY_MIN...RTAS_EXTENDED_DELAY_MAX
> differently, which is part of the point of this change.

I think it would reduce confusion overall to:

  - add RTAS_HARDWARE_ERROR, RTAS_INVALID_SENSOR to rtas.h

  - rename and move SLOT_UNISOLATED, etc to rtas.h; they look
    analogous to function-specific things like RTAS_SUSPEND_ABORTED

  - change rtas_error_rc() to use the RTAS_HARDWARE_ERROR, etc
    constants

  - use the constants (SLOT_NOT_USABLE) instead of "9902" in the
    commit log and code comments

> Aside: rtas_error_rc() (from powerpc's rtas.c) is badly named. Its
> conversions make sense for only a handful of RTAS calls. RTAS error
> codes have function-specific interpretations.

Maybe there's a case for factoring out the generic error codes and
have rtas_to_errno() (which sounds like maybe it should be renamed as
well) handle the function-specific part and fall back to the generic
one otherwise:

  int rtas_to_errno(int rtas_rc)
  {
    switch (rtas_rc) {
    case SLOT_UNISOLATED:
    case SLOT_NOT_UNISOLATED:
      return -EINVAL;
    case SLOT_NOT_USABLE:
      return -ENODEV;
    ...
    default:
      return rtas_error_rc(rtas_rc);
    }
  }
