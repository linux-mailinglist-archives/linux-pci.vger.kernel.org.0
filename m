Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF853E9ECF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhHLGtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 02:49:50 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45947 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233567AbhHLGtu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 02:49:50 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DF8255C00EB;
        Thu, 12 Aug 2021 02:49:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 12 Aug 2021 02:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=7tumxtnlUFmqcDNOcJ47r7kQUco
        YA0a+Ye8p8V4K8f4=; b=g/5E8jn8FWxiDYkpiYRmkneKF9SN4WjUCz7ct7j0OQT
        sEXB3cQ6CqMTn75GHh+X0oG5r7A9gYK2/dqC1rn0Nhy5ayMild9xn1wXIBsLgd8y
        anuNOwQnpynWmuUy8c+Uo1GcsIEdvUhAVPM8Mx+VMUkqNaodprxX3PAUkgJsEz3a
        mz9+b36kumggPgFKxL75s7i7FMlIQ2YFfBtcs+a8hQa0jWiiloqdMhQ1hRhfbRAs
        lZUao9xbGY56Qwk/h6kpU7YBR+uF2j5K9s14BPS5yJ45VK2bqHUq3AMGzpVj4bDA
        uj/SvD8hQ9D0XZyNgcoBugEoec9QdZWkXwaOsAaAOQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7tumxt
        nlUFmqcDNOcJ47r7kQUcoYA0a+Ye8p8V4K8f4=; b=nRfbpaXW0mrcWyOUxOA3Dp
        cLQn9yUvRtuuhFejrpsoWoP8QCjyaEepM0FjKqIEprRgB5U9V942gJsPhbA5OnPt
        VnvI5pq3ubX+9mg1mJUX/yA8kI1Nzw75+hFLKjMwYstjiwgr9SnMYyfpB35O5TJ2
        U13ZSiqPajZGRXJhsp7h4rFjz9tT6Tt7eaDYVNSNO8cNjGsXYTD9c9+psFnApu/p
        ehMKEsTBOZMVnIKYzLCAjgafiJTntwNyJOE6dGrgOUkU1saSU/AUPlFf2NrAbDPg
        7JRmHqoSzVRyZ0iaY+Ys9/Suhq2wDCJK36K0sJuKTve8kF2BgmKkZjMXOZlQbSXg
        ==
X-ME-Sender: <xms:dMQUYQphzqRkZ2HiEbkss8afgKmhm_y0dfSSShNW0FupZyOq83qoUg>
    <xme:dMQUYWppPADCfRGeS6-EHieeq9pKD4rpBBaDwM_DMEeTfMpqHKPDq3gR7C8AnLDHe
    gWn37lFWx2YVw>
X-ME-Received: <xmr:dMQUYVN2hnHJSi9WE7WZV8RFmB1-M34hLiBrtyhXBo0o3WY_U02oM4gANZEGTIHTGfmxmVLUzCEZDxmnHvPNfJC2uAM56Gst>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedvgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:dMQUYX5f9ndG9qfz2Dl1Wm0Q6kbMiSyCMYapAkijLh-DuqIhQ2-B7g>
    <xmx:dMQUYf6gHfaqoEV9-qyF49xF2elM8TvK0Ilom7aNjgZ5eAyk8_dbjg>
    <xmx:dMQUYXhcUJjcEuM-RdCfZ_oiCzbaGRstggucEvkekK88_PWXBpMtHg>
    <xmx:dMQUYZuZW9V_OZNExTQ16o9gYwhPkcat1JpG_lf29AM9NMK8WEon5A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Aug 2021 02:49:24 -0400 (EDT)
Date:   Thu, 12 Aug 2021 08:49:21 +0200
From:   Greg KH <greg@kroah.com>
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove duplicate #ifdef in pci_try_set_mwi()
Message-ID: <YRTEcd0S2/2XlL7p@kroah.com>
References: <20210811234601.341947-1-utkarshverma294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811234601.341947-1-utkarshverma294@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 12, 2021 at 05:16:01AM +0530, Utkarsh Verma wrote:
> Remove the unnecessary #ifdef PCI_DISABLE_MWI, because pci_set_mwi()
> performs the same check.
> 
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  drivers/pci/pci.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575c15cf..7d4c7c294ef2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4456,11 +4456,7 @@ EXPORT_SYMBOL(pcim_set_mwi);
>   */
>  int pci_try_set_mwi(struct pci_dev *dev)
>  {
> -#ifdef PCI_DISABLE_MWI
> -	return 0;
> -#else
>  	return pci_set_mwi(dev);
> -#endif
>  }
>  EXPORT_SYMBOL(pci_try_set_mwi);

If this is the case, why do we even need pci_try_set_mwi()?  Why not
just replace it with calls to pci_set_mwi() and then delete this one?

thanks,

greg k-h
