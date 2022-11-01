Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BED6149F2
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 12:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiKALwF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 07:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKALvx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 07:51:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5CA63AC;
        Tue,  1 Nov 2022 04:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BD05B81C9C;
        Tue,  1 Nov 2022 11:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C53C433D6;
        Tue,  1 Nov 2022 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667303363;
        bh=EYg9ddTaNOtk/aT096ywrtAVf6CeLH/1AkjkhmXUsqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngQS2na3QgrYDxZz6uyZUuhPjt1ieHU3KmSC3OydZV3vZG+yFu/351tq5DbvTXA5q
         RzslUSKSyhv9TYzHmwoI6nGviFJG4m/sxO315tQSXLjAP0vyJnbGk3P8uqw2zRIutN
         PtJovBWUE8vLwS9e5wBBr3ix9ly+doViYH6ot6dRvchdkJ+YfLJ5fo/3fPMPTHEGWy
         nA1oCCKno/AZ5ZeZF34VQ+jlymU2j/UOC7GkkUf250ymHGWUDpjOIhsYCezrnHCFnC
         6+HdzJrVJcYP8o2b7Lg7qbyzZak0uTjJM0oNKgJA0uWKyEEj/4zuYsfi4id+m8A/4Z
         Co8RS+lT1ZlSw==
Date:   Tue, 1 Nov 2022 17:19:08 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
        helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        ntb@lists.linux.dev
Subject: Re: [PATCH v14 1/7] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc
 warning
Message-ID: <20221101114908.GE54667@thinkpad>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
 <20221028155703.318928-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028155703.318928-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 28, 2022 at 11:56:57AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> Cleanup warning found by scripts/kernel-doc
> Consolidate term
>     host, host1 to HOST
>     vhost, vHost, Vhost, VHOST2 to VHOST
> 
> Signed-off-by: Frank Li <frank.li@nxp.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 83 ++++++++++++-------
>  1 file changed, 54 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 0ea85e1d292e..c0115bcb3b5e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -11,7 +11,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> -/**
> +/*
>   * +------------+         +---------------------------------------+
>   * |            |         |                                       |
>   * +------------+         |                        +--------------+
> @@ -156,12 +156,14 @@ static struct pci_epf_header epf_ntb_header = {
>  };
>  
>  /**
> - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host
> + * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
>   * @link_up: true or false indicating Link is UP or Down
>   *
>   * Once NTB function in HOST invoke ntb_link_enable(),
> - * this NTB function driver will trigger a link event to vhost.
> + * this NTB function driver will trigger a link event to VHOST.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  {
> @@ -175,9 +177,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  }
>  
>  /**
> - * epf_ntb_configure_mw() - Configure the Outbound Address Space for vhost
> - *   to access the memory window of host
> - * @ntb: NTB device that facilitates communication between host and vhost
> + * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
> + *   to access the memory window of HOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   * @mw: Index of the memory window (either 0, 1, 2 or 3)
>   *
>   *                          EP Outbound Window
> @@ -194,7 +196,9 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>   * |        |              |           |
>   * |        |              |           |
>   * +--------+              +-----------+
> - *  VHost                   PCI EP
> + *  VHOST                   PCI EP
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
>  {
> @@ -219,7 +223,7 @@ static int epf_ntb_configure_mw(struct epf_ntb *ntb, u32 mw)
>  
>  /**
>   * epf_ntb_teardown_mw() - Teardown the configured OB ATU
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   * @mw: Index of the memory window (either 0, 1, 2 or 3)
>   *
>   * Teardown the configured OB ATU configured in epf_ntb_configure_mw() using
> @@ -234,12 +238,12 @@ static void epf_ntb_teardown_mw(struct epf_ntb *ntb, u32 mw)
>  }
>  
>  /**
> - * epf_ntb_cmd_handler() - Handle commands provided by the NTB Host
> + * epf_ntb_cmd_handler() - Handle commands provided by the NTB HOST
>   * @work: work_struct for the epf_ntb_epc
>   *
>   * Workqueue function that gets invoked for the two epf_ntb_epc
>   * periodically (once every 5ms) to see if it has received any commands
> - * from NTB host. The host can send commands to configure doorbell or
> + * from NTB HOST. The HOST can send commands to configure doorbell or
>   * configure memory window or to update link status.
>   */
>  static void epf_ntb_cmd_handler(struct work_struct *work)
> @@ -321,8 +325,8 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  /**
>   * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
> - * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
> - *	     address.
> + * @ntb: EPC associated with one of the HOST which holds peer's outbound
> + *	 address.
>   *
>   * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
>   * self scratchpad region (removes inbound ATU configuration). While BAR0 is
> @@ -331,8 +335,10 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>   * used for self scratchpad from epf_ntb_bar[BAR_CONFIG].
>   *
>   * Please note the self scratchpad region and config region is combined to
> - * a single region and mapped using the same BAR. Also note HOST2's peer
> - * scratchpad is HOST1's self scratchpad.
> + * a single region and mapped using the same BAR. Also note VHOST's peer
> + * scratchpad is HOST's self scratchpad.
> + *
> + * Returns: void
>   */
>  static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
>  {
> @@ -347,13 +353,15 @@ static void epf_ntb_config_sspad_bar_clear(struct epf_ntb *ntb)
>  
>  /**
>   * epf_ntb_config_sspad_bar_set() - Set Config + Self scratchpad BAR
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
> - * Map BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
> + * Map BAR0 of EP CONTROLLER which contains the VHOST's config and
>   * self scratchpad region.
>   *
>   * Please note the self scratchpad region and config region is combined to
>   * a single region and mapped using the same BAR.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
>  {
> @@ -380,7 +388,7 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
>  /**
>   * epf_ntb_config_spad_bar_free() - Free the physical memory associated with
>   *   config + scratchpad region
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   */
>  static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>  {
> @@ -393,11 +401,13 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>  /**
>   * epf_ntb_config_spad_bar_alloc() - Allocate memory for config + scratchpad
>   *   region
> - * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
>   * Allocate the Local Memory mentioned in the above diagram. The size of
>   * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
>   * is obtained from "spad-count" configfs entry.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  {
> @@ -465,11 +475,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  }
>  
>  /**
> - * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capaiblity
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * epf_ntb_configure_interrupt() - Configure MSI/MSI-X capability
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
>   * Configure MSI/MSI-X capability for each interface with number of
>   * interrupts equal to "db_count" configfs entry.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
> @@ -511,7 +523,9 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  
>  /**
>   * epf_ntb_db_bar_init() - Configure Doorbell window BARs
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  {
> @@ -566,7 +580,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
>  /**
>   * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
>   *   allocated in peer's outbound address space
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   */
>  static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>  {
> @@ -582,8 +596,9 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>  
>  /**
>   * epf_ntb_mw_bar_init() - Configure Memory window BARs
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> @@ -639,7 +654,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  
>  /**
>   * epf_ntb_mw_bar_clear() - Clear Memory window BARs
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   */
>  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  {
> @@ -662,7 +677,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  
>  /**
>   * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
>   * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
>   */
> @@ -675,7 +690,9 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
>  /**
>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
>   * constructs (scratchpad region, doorbell, memorywindow)
> - * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  {
> @@ -716,11 +733,13 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  
>  /**
>   * epf_ntb_epc_init() - Initialize NTB interface
> - * @ntb: NTB device that facilitates communication between HOST and vHOST2
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
>   * Wrapper to initialize a particular EPC interface and start the workqueue
> - * to check for commands from host. This function will write to the
> + * to check for commands from HOST. This function will write to the
>   * EP controller HW for configuring it.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  {
> @@ -787,7 +806,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>  
>  /**
>   * epf_ntb_epc_cleanup() - Cleanup all NTB interfaces
> - * @ntb: NTB device that facilitates communication between HOST1 and HOST2
> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>   *
>   * Wrapper to cleanup all NTB interfaces.
>   */
> @@ -951,6 +970,8 @@ static const struct config_item_type ntb_group_type = {
>   *
>   * Add configfs directory specific to NTB. This directory will hold
>   * NTB specific properties like db_count, spad_count, num_mws etc.,
> + *
> + * Returns: Pointer to config_group
>   */
>  static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
>  					    struct config_group *group)
> @@ -1292,6 +1313,8 @@ static struct pci_driver vntb_pci_driver = {
>   * Invoked when a primary interface or secondary interface is bound to EPC
>   * device. This function will succeed only when EPC is bound to both the
>   * interfaces.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_bind(struct pci_epf *epf)
>  {
> @@ -1377,6 +1400,8 @@ static struct pci_epf_ops epf_ntb_ops = {
>   *
>   * Probe NTB function driver when endpoint function bus detects a NTB
>   * endpoint function.
> + *
> + * Returns: Zero for success, or an error code in case of failure
>   */
>  static int epf_ntb_probe(struct pci_epf *epf)
>  {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
