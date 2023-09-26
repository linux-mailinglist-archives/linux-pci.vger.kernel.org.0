Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB307AF859
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 04:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjI0C6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 22:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbjI0C4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 22:56:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583791E3D1;
        Tue, 26 Sep 2023 15:27:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AFAC433B7;
        Tue, 26 Sep 2023 21:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695762505;
        bh=NHrasjdUccDQ1T+en6JKvDtf7CH4weteRN2zEaxErm0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kXIPo9DdUuXQ6B2yFu/VVM+TspTFD7CsD26Hb0t/w/1d5YdOxgA9pdtXguhKUMLQU
         XKbUvsbseZ6OETesX3+oSlTUaEjML3+uiHUFU9umiEWUfAWE6jBQZ/NzJeq5rEz4TA
         pIfwx5ovbugC+eC9omwJDUSQMcbrCuayCvR9uVnAlUzkWEq1kc/+wZjD5muEBp7qCi
         DLHhBQsbMjnoMdeWUc+xuEICM6/05Zp2HB7Vd6krqzX4DqfPMSk9XKqHGKpUO3e+C4
         ldX2SiKl61GLitH7PV7jOTt1U+/wf7KJfc0FrV6BwhngCkLdIbvjjI2BJjYh1+Rsnr
         kGj4x7w62bfEA==
Date:   Tue, 26 Sep 2023 16:08:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH] PCI: qcom: Add interconnect bandwidth for PCIe Gen4
Message-ID: <20230926210823.GA427669@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230924160713.217086-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 24, 2023 at 06:07:13PM +0200, Manivannan Sadhasivam wrote:
> PCIe Gen4 supports the interconnect bandwidth of 1969 MBps. So let's add
> the bandwidth support in the driver. Otherwise, the default bandwidth of
> 985 MBps will be used.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 297442c969b6..6853123f92c1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1384,11 +1384,14 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  	case 2:
>  		bw = MBps_to_icc(500);
>  		break;
> +	case 3:
> +		bw = MBps_to_icc(985);
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		fallthrough;
> -	case 3:
> -		bw = MBps_to_icc(985);
> +	case 4:
> +		bw = MBps_to_icc(1969);

The bare numbers here are sort of weird.  I assume they correspond to
the Supported Link Speeds Vector in Link Cap 2, and I expected them to
correspond somehow to PCIE_SPEED2MBS_ENC(), which computes the usable
PCIe bandwidth per lane.  I see the ratios between 250, 500, 986, 1969
*do* match up with the ratios of PCIE_SPEED2MBS_ENC() values, but I
don't know the PCIE_SPEED2MBS_ENC() values aren't used:

            SLS Vector                         PCIE_SPEED2MBS_ENC()
  CLS 1:  bit 0  2.5 GT/s   MBps_to_icc(250)      2000 Mbps
  CLS 2:  bit 1  5.0 GT/s   MBps_to_icc(500)      4000 Mbps
  CLS 3:  bit 2  8.0 GT/s   MBps_to_icc(985)      7879 Mbps
  CLS 4:  bit 3 16.0 GT/s   MBps_to_icc(1969)    15753 Mbps

This is just my curiosity, probably no change is needed, or at most a
short comment.

I do notice that pcie-qcom-ep.c uses #defines like PCIE_GEN1_BW_MBPS,
and it seems like both could use the same style.

Also agree with Konrad that the ordering ends up looking unusual;
maybe would be more readable if the default case repeated the speed
you want instead of using the fallthrough.

>  		break;
>  	}
