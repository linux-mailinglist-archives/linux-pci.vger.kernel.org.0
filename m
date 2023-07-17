Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53957756FF2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 00:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGQWm5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 18:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGQWm5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 18:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C4E97;
        Mon, 17 Jul 2023 15:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A656D612DD;
        Mon, 17 Jul 2023 22:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A66C433C8;
        Mon, 17 Jul 2023 22:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689633775;
        bh=BWnev0VZCcMTwzzFzXjWACsLpmchQGgvzMThaGbhnZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jfiWG9EutL1bzGEC2jcUAMASWaHuLmrKizWWsctHIdUfPh1pCkE6GGk2lcfb9Oh44
         avuJ8wlTmrQ9BAqMCyfjZiQLIj9uPADnfPkFkQW0JW+oOr3mskr4QmN6fZQ6iudIrr
         P+nUTwc8xO3L0oIBNzWmMxkqoI1kTApd+me7P/jg8GTANk0C7lAjksJWedNDqz8muK
         SxSORvwS1UhXnfnPTu8Jio73vej+vwQlpQqF/KdxfP16Eohoyg3T5rca1jWUj6K2Gm
         1TpmDEZ3shEuNqKslpkOig4IT48xEn91VhxaixfrrIsMos84LWXDl+XLP4MO7CxKFg
         aO8NSyH9y2nLg==
Date:   Mon, 17 Jul 2023 17:42:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
        linux-pci@vger.kernel.org, jesse.brandeburg@intel.com,
        linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        anthony.l.nguyen@intel.com, linux-hardening@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Aaron Ma <aaron.ma@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH v2] igc: Ignore AER reset when device
 is suspended
Message-ID: <20230717224252.GA461492@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p4Owt_ygt2f=38M0X2MxnPsXv=BHzSLRbprwW208MUVdQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 17, 2023 at 03:38:09PM +0800, Kai-Heng Feng wrote:
> On Fri, Jul 14, 2023 at 10:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 14, 2023 at 01:05:41PM +0800, Kai-Heng Feng wrote:
> > > When a system that connects to a Thunderbolt dock equipped with I225,
> > > like HP Thunderbolt Dock G4, I225 stops working after S3 resume:
> > > ...
> >
> > > The issue is that the PTM requests are sending before driver resumes the
> > > device. Since the issue can also be observed on Windows, it's quite
> > > likely a firmware/hardware limitation.
> >
> > Does this mean we didn't disable PTM correctly on suspend?  Or is the
> 
> PTM gets disabled correctly during suspend, by commit c01163dbd1b8
> ("PCI/PM: Always disable PTM for all devices during suspend").
> Before that commit the suspend will fail.
> 
> > device defective and sending PTM requests even though PTM is disabled?
> 
> Yes. When S3 resume, I guess the firmware resets the dock and/or I225
> so PTM request starts even before the OS is resumed.
> AFAIK the issue doesn't happen when s2Idle is used.

A reset should disable PTM.  I wonder if dock firmware could be
enabling PTM?  That would seem like a defect to me, because the dock
can't know whether the Downstream Port in the laptop has PTM enabled.

> > If the latter, I vote for a quirk that just disables PTM completely
> > for this device.
> 
> The S3 resume enables PTM regardless of OS involvement. So I don't
> think this will work.

That's ... weird.  So something other than the OS enables PTM?  Not
sure how we can deal with that.  Some (probably most) laptop Root
Ports don't support PTM at all, so plugging the dock into one of those
would always cause errors.

> > This check in .error_detected() looks out of place to me because
> > there's no connection between AER and PTM, there's no connection
> > between PTM and the device being enabled, and the connection between
> > the device being enabled and being fully resumed is a little tenuous.
> 
> True. This patch is just a workaround.
> 
> Have you considered my other proposed approach? Like disable AER
> completely during suspend, or even defer the resuming of PCIe services
> after the entire hierarchy is resumed?

We might need to disable AER in certain cases where errors are
unavoidable, like a surprise unplug that causes data link errors when
the plug gets yanked out.

But this PTM thing is not like that -- this is a configuration error,
and I think we should fix the configuration instead of ignoring the
error.

> > > So avoid resetting the device if it's not resumed. Once the device is
> > > fully resumed, the device can work normally.

I'm a little confused about how this workaround works.  The subject
says "ignore AER reset", but here you say *avoid* resetting the
device.

I think we only reset things in the AER_FATAL case, and the PTM UR is
an AER_NONFATAL error, so I'm not sure what the effect of this patch
is.

Also, igc_io_error_detected() needs to return one of the
pci_ers_result values, not zero.  Zero isn't a valid return value, so
we can't rely on how pcie_do_recovery() handles it.

> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216850
> > > Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> > > Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >
> > > ---
> > > v2:
> > >  - Fix typo.
> > >  - Mention the product name.
> > >
> > >  drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > index 9f93f0f4f752..8c36bbe5e428 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -7115,6 +7115,9 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
> > >       struct net_device *netdev = pci_get_drvdata(pdev);
> > >       struct igc_adapter *adapter = netdev_priv(netdev);
> > >
> > > +     if (!pci_is_enabled(pdev))
> > > +             return 0;
> > > +
> > >       netif_device_detach(netdev);
> > >
> > >       if (state == pci_channel_io_perm_failure)
> > > --
> > > 2.34.1
> > >
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
